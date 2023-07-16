import 'package:under/feature/atoms/sign_in_atom.dart';

import '../api/service/service.dart';

class SignInReducer {
  final AuthService _authService;

  SignInReducer(this._authService) {
    fetchSignIn.addListener(_fetchSignIn);
  }

  _fetchSignIn() async {
    final signInDTO = fetchSignIn.value;

    await _authService.fetchLogin(signInDTO);
  }

  dispose() {
    fetchSignIn.dispose();
  }
}
