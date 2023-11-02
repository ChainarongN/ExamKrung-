import 'dart:convert';
import 'package:exam_credit_card/data/exception/app_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class ApiService {
  Future getApi({String? entpoint}) async {
    var response;
    final url = Uri.parse(entpoint!);
    try {
      response = await http.get(url);
      response = await _returnResponse(response);
    } catch (e) {
      debugPrint(e.toString());
    }

    return response;
  }

  Future getApiUnbilled({String? cardNumber}) async {
    var response;
    Uri url = Uri.parse(
        "https://card-management-eajwtocuqa-as.a.run.app/v1/unbilled-statements?cardNumber=$cardNumber");
    try {
      response = await http.get(url);
      response = await _returnResponse(response);
    } catch (e) {
      debugPrint(e.toString());
    }

    return response;
  }

  Future getApibilled({String? cardNumber, String? asOf}) async {
    var response;
    Uri url = Uri.parse(
        "https://card-management-eajwtocuqa-as.a.run.app/v1/billed-statements?cardNumber=$cardNumber&asOf=$asOf");
    try {
      response = await http.get(url);
      response = await _returnResponse(response);
    } catch (e) {
      debugPrint(e.toString());
    }

    return response;
  }

  dynamic _returnResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        // var responseJson = response.body;
        // print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw ServerNotFoundException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
