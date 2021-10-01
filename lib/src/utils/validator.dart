class ValidatorsLumen {
  validarCurp(value) {
    print(value);
    if (value.isEmpty || value.length < 1) {
      return 'No puede ir vacío';
    }
    if (value.length < 18) {
      return 'El curp no puede ser menor a 18 caracteres';
    }
  }

  notEmptyField(value) {
    if (value.isEmpty || value.length < 1) {
      return 'No puede ir vacío';
    }
  }

  selectSelected(value) {
    if (value == null) {
      return 'Debe seleccionar una opción';
    }
  }

  validateEmail(value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    print("email es : > $emailValid");
    if (emailValid == false) {
      return "El email es inválido";
    }
  }

  validateCellphone(value) {
    if (value.trim().length < 10) {
      return "Deben ser 10 dígitos";
    }
  }

  validateImage(value) {
    if (value == "") {
      return "ésta imagen no puede ir vacía";
    }
  }
}
