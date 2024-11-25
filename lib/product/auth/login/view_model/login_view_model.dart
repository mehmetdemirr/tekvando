import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  bool passwordVisibility = true;

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }
}
