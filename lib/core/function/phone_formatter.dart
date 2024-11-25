import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  PhoneNumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!oldValue.text.contains('(') &&
        oldValue.text.length >= 10 &&
        newValue.text.length != oldValue.text.length) {
      return const TextEditingValue(
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    if (oldValue.text.length > newValue.text.length) {
      return TextEditingValue(
        text: newValue.text,
        selection: TextSelection.collapsed(offset: newValue.text.length),
      );
    }

    var newText = newValue.text;
    if (newText.length == 1) newText = '($newText';
    if (newText.length == 4) newText = '$newText) ';
    if (newText.length == 9) newText = '$newText ';

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
