class CreditCardPayment {
  String cardNumber;
  String expiryDate;
  String cardHolderName;
  String cvvCode;
  bool isCvvFocused;

  CreditCardPayment(
      {required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.isCvvFocused});
}

class LocalPayment {
  String name;
  int phoneNumber;
  String serviceName;

  LocalPayment({required this.name, required this.phoneNumber, required this.serviceName});
}
