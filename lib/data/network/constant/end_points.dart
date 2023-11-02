class Endpoints {
  Endpoints._();

  static const String baseUrl =
      "https://card-management-eajwtocuqa-as.a.run.app/v1";
  static const String urlCeditCard =
      "https://card-management-eajwtocuqa-as.a.run.app/v1/cards/1111111111111";

  // https://card-management-eajwtocuqa-as.a.run.app/v1/cards/1111111111111
  // https://card-management-eajwtocuqa-as.a.run.app/v1/unbilled-statements?cardNumber=4568111122223333
  // https://card-management-eajwtocuqa-as.a.run.app/v1/billed-statements?cardNumber=4568111145334321&asOf=072023
     

//endpoints
  static const String unbilled = "/unbilled-statements";
  static const String billed = "/billed-statements";
}
