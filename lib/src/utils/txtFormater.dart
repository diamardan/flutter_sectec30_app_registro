import 'package:flutter/services.dart';
import 'package:characters/characters.dart';

class TextoMinusculas extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew) {
    return txtNew.copyWith(text: txtNew.text.toLowerCase());
  }
}

class TextoMayusculas extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew) {
    return txtNew.copyWith(text: txtNew.text.toUpperCase());
  }
}

class DigitosLimite extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue txtOld, TextEditingValue txtNew) {
    return txtNew.copyWith(text: txtNew.text.toUpperCase().characters.take(18).toString());
  }

}
