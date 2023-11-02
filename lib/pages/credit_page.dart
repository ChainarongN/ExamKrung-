import 'package:awesome_card/awesome_card.dart';
import 'package:exam_credit_card/pages/credit_viewmodel.dart';
import 'package:exam_credit_card/utils/constant_value.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreditPage extends StatefulWidget {
  const CreditPage({super.key});

  @override
  State<CreditPage> createState() => _CreditPageState();
}

class _CreditPageState extends State<CreditPage> {
  @override
  void initState() {
    Provider.of<CreditViewModel>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CreditViewModel>(
        builder: (context, data, child) => data.ceditModel != null
            ? DefaultTabController(
                initialIndex: 0,
                length: 3,
                child: Column(
                  children: <Widget>[
                    craditCard(data),
                    tabBar(),
                    tabView(),
                  ],
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  GestureDetector craditCard(CreditViewModel data) {
    return GestureDetector(
      onPanUpdate: (details) {
        // Swiping in right direction.
        if (details.delta.dx > 0) {
          if (!data.status) {
            data.changeCard();
          }
        }
        // Swiping in left direction.
        if (details.delta.dx < 0) {
          if (!data.status) {
            data.changeCard();
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(top: 55, bottom: 10),
        child: CreditCard(
            height: 200,
            cardNumber: "${data.cardNumber}",
            cardHolderName: "Card Holder",
            cvv: "456",
            bankName: "Krungsri",
            cardType: CardType
                .masterCard, // Optional if you want to override Card Type
            showBackSide: false,
            frontBackground: CardBackgrounds.black,
            backBackground: CardBackgrounds.white,
            showShadow: true,
            textExpDate: 'Exp. Date',
            textName: 'Name',
            textExpiry: 'MM/YY'),
      ),
    );
  }

  Consumer tabView() {
    return Consumer<CreditViewModel>(
      builder: (context, data, child) => Expanded(
        child: TabBarView(children: [
          accountInfo(data),
          unbilled(data),
          billed(data),
        ]),
      ),
    );
  }

  Padding billed(CreditViewModel data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('STATEMENT OF',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton(
                value: data.selectedLocation,
                onChanged: (newValue) {
                  data.setSelectDropDown(
                    newValue!,
                    Constants().dropDownList.indexOf(newValue),
                  );
                },
                items: Constants().dropDownList.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.billedList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${data.billedList[index].description}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        Text('${data.billedList[index].amount}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        Constants().dateFormat(
                            data.billedList[index].statementDate.toString()),
                        style: const TextStyle(fontSize: 11),
                      ),
                    ),
                    const Divider(height: 2),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  ListView unbilled(CreditViewModel data) {
    return ListView.builder(
      itemCount: data.unbilledList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${data.unbilledList[index].description}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('${data.unbilledList[index].amount}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  Constants().dateFormat(
                      data.unbilledList[index].statementDate.toString()),
                  style: const TextStyle(fontSize: 11),
                ),
              ),
              const Divider(height: 2),
            ],
          ),
        );
      },
    );
  }

  Padding accountInfo(CreditViewModel data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('AVAILABLE CREDIT', style: TextStyle(fontSize: 10)),
              Text('CREDIT LIMIT', style: TextStyle(fontSize: 10)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 5, bottom: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${data.ceditModel!.cards![data.indexCard!].availableCredit}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${data.ceditModel!.cards![data.indexCard!].creditLimit}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('MIN PAY', style: TextStyle(fontSize: 10)),
              Text('FULL PAY', style: TextStyle(fontSize: 10)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${data.ceditModel!.cards![data.indexCard!].minPay}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${data.ceditModel!.cards![data.indexCard!].fullPay}',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: const Divider(height: 2),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('STATEMENT DATE', style: TextStyle(fontSize: 10)),
              Text('DUE DATE', style: TextStyle(fontSize: 10)),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Constants().dateFormat(data
                      .ceditModel!.cards![data.indexCard!].statementDate
                      .toString()),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  Constants().dateFormat(data
                      .ceditModel!.cards![data.indexCard!].dueDate
                      .toString()),
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  TabBar tabBar() {
    return const TabBar(
      tabs: [
        Tab(
          child: Text('ACCOUNT INFO', style: TextStyle(fontSize: 12)),
        ),
        Tab(
          child: Text('UNBILLED', style: TextStyle(fontSize: 12)),
        ),
        Tab(
          child: Text('BILLED', style: TextStyle(fontSize: 12)),
        ),
      ],
    );
  }
}
