import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  bool passwordVisibility = true;
  bool passwordAgainVisibility = true;
  bool checkBox = false;

  void changePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    notifyListeners();
  }

  void changePasswordAgainVisibility() {
    passwordAgainVisibility = !passwordAgainVisibility;
    notifyListeners();
  }

  void changeCheckBox() {
    checkBox = !checkBox;
    notifyListeners();
  }
}
