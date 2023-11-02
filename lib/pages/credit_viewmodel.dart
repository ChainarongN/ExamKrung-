import 'package:exam_credit_card/utils/constant_value.dart';
import 'package:exam_credit_card/data/network/api_service.dart';
import 'package:exam_credit_card/data/network/constant/end_points.dart';
import 'package:exam_credit_card/model/billed_model.dart';
import 'package:exam_credit_card/model/credit_model.dart';
import 'package:exam_credit_card/model/unbilled_model.dart';
import 'package:flutter/material.dart';

class CreditViewModel extends ChangeNotifier {
  bool status = false;
  CeditModel? ceditModel;
  UnBilledModel? unBilledModel;
  BilledModel? billedModel;
  String? cardNumber, asOf = '082023';
  int? indexCard;
  List<UnBilledModel> unbilledList = [];
  List<BilledModel> billedList = [];
  String? selectedLocation = 'Aug 2023';

  Future init() async {
    await getCeditCard();
    await getUnbilled();
    await getbilled();
  }

  Future getCeditCard() async {
    var jsonData = await ApiService().getApi(entpoint: Endpoints.urlCeditCard);
    ceditModel = CeditModel.fromJson(jsonData);
    cardNumber = ceditModel!.cards![0].cardNumber;
    indexCard = 0;

    notifyListeners();
  }

  Future getUnbilled() async {
    unbilledList = [];
    var jsonData = await ApiService().getApiUnbilled(cardNumber: cardNumber);
    for (var element in jsonData) {
      unbilledList.add(UnBilledModel(
        description: element['description'],
        statementDate: element['statementDate'],
        amount: element['amount'],
      ));
    }

    notifyListeners();
  }

  Future getbilled() async {
    billedList = [];

    var jsonData =
        await ApiService().getApibilled(cardNumber: cardNumber, asOf: asOf);
    for (var element in jsonData) {
      billedList.add(BilledModel(
        description: element['description'],
        statementDate: element['statementDate'],
        amount: element['amount'],
      ));
    }

    notifyListeners();
  }

  Future changeCard() async {
    status = true;
    if (indexCard == 0) {
      cardNumber = ceditModel!.cards![1].cardNumber;
      indexCard = 1;
    } else {
      cardNumber = ceditModel!.cards![0].cardNumber;
      indexCard = 0;
    }
    await getUnbilled();
    await getbilled();
    status = false;

    notifyListeners();
  }

  Future setSelectDropDown(String newValue, int index) async {
    selectedLocation = newValue;
    asOf = Constants().dropDownNumberList[index];
    await getbilled();

    notifyListeners();
  }
}
