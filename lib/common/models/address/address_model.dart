class UserAddress {
  final String fullName;
  final String phoneNumber;
  final String country;
  final String city;
  final String zone;
  final String address;
  bool isDefault;
  String id;

  UserAddress(
      {required this.fullName,
      required this.phoneNumber,
      required this.country,
      required this.city,
      required this.zone,
      required this.address,
      required this.isDefault,
      required this.id});

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'country': country,
      'city': city,
      'zone': zone,
      'address': address,
      'isDefault': isDefault,
      'id': id
    };
  }

  UserAddress.fromJson(Map<String, dynamic> json)
      : fullName = json['fullName'],
        phoneNumber = json['phoneNumber'],
        country = json['country'],
        city = json['city'],
        zone = json['zone'],
        address = json['address'],
        isDefault = json['isDefault'],
        id = json['id'];
}
