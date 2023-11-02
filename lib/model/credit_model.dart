class CeditModel {
  String? citizenId;
  List<Cards>? cards;

  CeditModel({this.citizenId, this.cards});

  CeditModel.fromJson(Map<String, dynamic> json) {
    citizenId = json['citizenId'];
    if (json['cards'] != null) {
      cards = <Cards>[];
      json['cards'].forEach((v) {
        cards!.add(new Cards.fromJson(v));
      });
    }
  }
}

class Cards {
  String? cardName;
  String? cardHolderName;
  String? cardNumber;
  String? cardImageUrl;
  double? creditLimit;
  double? availableCredit;
  double? minPay;
  double? fullPay;
  String? statementDate;
  String? dueDate;

  Cards(
      {this.cardName,
      this.cardHolderName,
      this.cardNumber,
      this.cardImageUrl,
      this.creditLimit,
      this.availableCredit,
      this.minPay,
      this.fullPay,
      this.statementDate,
      this.dueDate});

  Cards.fromJson(Map<String, dynamic> json) {
    cardName = json['cardName'];
    cardHolderName = json['cardHolderName'];
    cardNumber = json['cardNumber'];
    cardImageUrl = json['cardImageUrl'];
    creditLimit = json['creditLimit'];
    availableCredit = json['availableCredit'];
    minPay = json['minPay'];
    fullPay = json['fullPay'];
    statementDate = json['statementDate'];
    dueDate = json['dueDate'];
  }
}
