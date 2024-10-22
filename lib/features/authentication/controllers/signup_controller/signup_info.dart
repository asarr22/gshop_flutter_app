import 'package:flutter/material.dart';

class SignUpInfo {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phoneNumber;
  final GlobalKey<FormState> signupKey;

  SignUpInfo({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.signupKey,
  });
}
