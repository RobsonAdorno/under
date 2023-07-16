import 'package:under/feature/atoms/sign_up_atom.dart';

import '../api/service/service.dart';
import '../entities/entities.dart';

class SignUpReducer {
  final AuthService _authService;

  SignUpReducer(this._authService) {
    signUpAction.addListener(_register);
  }

  Future<void> _register() async {
    UserModel user = signUpAction.value;

    if (user.cpf != null) {
      await _authService.register(user);
    }
  }

  dispose() {
    signUpAction.removeListener(_register);
  }
}
