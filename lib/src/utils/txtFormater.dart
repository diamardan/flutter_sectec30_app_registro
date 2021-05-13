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

class DigitosLimite extends LengthLimitingTextInputFormatter {
  DigitosLimite(int maxLength) : super(maxLength);
  @override
  TextEditingValue formatEditUpdate(
  TextEditingValue txtOld, TextEditingValue txtNew) {
        print("éste es el old $txtOld");
        print("éste es el new $txtNew");
        print("éste es el maxL $maxLength");
        /*
    if (txtOld.text.characters.length <= 18) {
      return txtNew.copyWith(
          text: txtNew.text.toUpperCase().characters.take(18).toString());
    }
    return txtNew.copyWith(
      text: txtOld.text,
      composing: TextRange(start: 0, end: 18)
    ); */ //.characters. .take(18).toString());
    txtNew = txtNew.copyWith(text: txtNew.text.toUpperCase());

    if (maxLength != null &&
        maxLength > 0 &&
        txtNew.text.characters.length > maxLength) {
      // If already at the maximum and tried to enter even more, keep the old
      // value.
      if (txtOld.text.characters.length == maxLength) {
        txtOld = txtOld.copyWith(text:txtOld.text.toUpperCase());
        return txtOld;
      }
      // ignore: invalid_use_of_visible_for_testing_member
      return LengthLimitingTextInputFormatter.truncate(txtNew, maxLength);
    }
    return txtNew;
  }
  
}
