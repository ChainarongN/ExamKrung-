class UnBilledModel {
  String? description;
  String? statementDate;
  double? amount;

  UnBilledModel({this.description, this.statementDate, this.amount});

  UnBilledModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    statementDate = json['statementDate'];
    amount = json['amount'];
  }

  @override
  String toString() {
    return "description: $description - statementDate: $statementDate - amount: $amount";
  }
}
