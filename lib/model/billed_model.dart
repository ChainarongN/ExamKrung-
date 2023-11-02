class BilledModel {
  String? description;
  String? statementDate;
  double? amount;

  BilledModel({this.description, this.statementDate, this.amount});

  BilledModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    statementDate = json['statementDate'];
    amount = json['amount'];
  }

  @override
  String toString() {
    return "description: $description - statementDate: $statementDate - amount: $amount";
  }
}
