import 'package:flutter/services.dart';

class MoneyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // TODO: implement formatEditUpdate
    // throw UnimplementedError();

    String newText = newValue.text;

    if (newText == '.') {
      newText = '0.';
    } else if (newText.contains('.')) {
      if (newText.lastIndexOf('.') != newText.indexOf('.')) {
        newText = newText.substring(0, newText.lastIndexOf('.'));
      } else if (newText.length - 1 - newText.indexOf('.') > 2) {
        newText = newText.substring(0, newText.indexOf('.') + 3);
      }
    }

    return TextEditingValue(
      text: newText,
      selection: new TextSelection.collapsed(offset: newText.length),
    );
  }
}
