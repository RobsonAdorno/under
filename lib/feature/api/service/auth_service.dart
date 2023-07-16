import 'package:under/feature/atoms/sign_in_atom.dart';
import 'package:under/feature/atoms/sign_up_atom.dart';
import 'package:under/feature/entities/entities.dart';
import 'package:under/feature/state/sign_up_state.dart';

import '../../state/sign_in_state.dart';
import '../api.dart';
import '/feature/api/repository/repository.dart';
import '/feature/dto/dto.dart';

class AuthService {
  final AuthenticationRepository _authenticationRepository;

  AuthService(this._authenticationRepository);

  Future<void> fetchLogin(SignInDTO signInDTO) async {
    singInState.value = SignInLoading();

    Result result = await _authenticationRepository.fetchLogin(signInDTO);

    if (result is Failure) {
      singInState.value = SignInError(result.exception.toString());
      return;
    }

    if (result is Sucess) {
      singInState.value = SignInFetch(result.value);
      return;
    }

    singInState.value = SignInStart();
  }

  Future<void> register(UserModel userModel) async {
    signupState.value = SignUpLoadingState();

    Result result = await _authenticationRepository.register(userModel);

    if (result is Failure) {
      signupState.value =
          SignUpErrorState(message: result.exception.toString());
    }

    if (result is Sucess) {
      signupState.value = SignUpSucessState(userModel: userModel);
    }
  }
}
