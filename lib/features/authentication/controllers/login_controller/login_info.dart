import 'package:flutter/material.dart';

class LoginInfo {
  final String email;
  final String password;
  final GlobalKey<FormState> signinKey;

  LoginInfo({
    required this.email,
    required this.password,
    required this.signinKey,
  });
}
