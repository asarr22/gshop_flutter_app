import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gshopp_flutter/common/models/address/address_model.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String username;
  final String email;
  String phoneNumber;
  String profilePicture;
  String birthday;
  String gender;
  List<UserAddress> address;
  List<String> favorites;

  /// Constructor for UserModel.
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.address,
    required this.birthday,
    required this.gender,
    this.favorites = const [],
  });

  /// Helper function to get the full name.
  String get fullName => '$firstName $lastName';

  /// Static function to split full name into first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  /// Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName"; // Combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUsername"; // Add "cwt_" prefix
    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
      id: '',
      firstName: '',
      lastName: '',
      username: '',
      email: '',
      phoneNumber: '',
      profilePicture: '',
      address: [],
      birthday: '',
      favorites: [],
      gender: '');

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> nonEmptyAddresses =
        address.where((a) => a.id.isNotEmpty).map((a) => a.toJson()).toList();

    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': username,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Gender': gender,
      'Address': nonEmptyAddresses,
      'Birthday': birthday,
      'Favorites': favorites
    };
  }

  /// Factory method to create a UserModel from a Firebase document snapshot.
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      List<UserAddress> addresses = [];
      if (data['Address'] != null) {
        addresses = List.from(data['Address']).map((addressMap) => UserAddress.fromJson(addressMap)).toList();
      }
      List<String> favorites = [];
      if (data['Favorites'] != null) {
        favorites = List.from(data['Favorites']);
      }
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        username: data['Username'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
        address: addresses,
        birthday: data['Birthday'] ?? '',
        gender: data['Gender'] ?? '',
        favorites: data['Favorites'] ?? favorites,
      );
    }
    return empty();
  }
}
