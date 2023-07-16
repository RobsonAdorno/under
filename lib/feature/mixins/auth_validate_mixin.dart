import 'package:under/feature/exceptions/exceptions.dart';

mixin class AuthValidateMixin {
  (int?, ValidateException?) nameValidate(String name) {
    if (name.isEmpty) {
      return (null, 'O nome não pode ser vazio'.asException());
    }

    if (name.length <= 6) {
      return (
        null,
        'Campo não pode ser menor que seis caracteres'.asException()
      );
    }

    return (0, null);
  }

  (int?, ValidateException?) email(String email) {
    if (email.isEmpty) {
      return (null, 'O email não pode ser vazio'.asException());
    }

    return (0, null);
  }
}
