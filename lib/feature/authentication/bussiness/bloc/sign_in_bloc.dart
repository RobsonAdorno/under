import 'package:bloc/bloc.dart';
import 'package:under/feature/authentication/bussiness/repository/i_auth_repository.dart';

import '../../../api/result_request.dart';
import '../event/signin_event.dart';
import '../state/signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  IAuthRepository authRepository;

  SignInBloc({
    required this.authRepository,
  }) : super(InitSignInState()) {
    on<FetchLoginEvent>(fetchLogin);
  }

  void fetchLogin(FetchLoginEvent event, Emitter emitter) async {
    emitter(LoadingSignInState());

    Result result = await authRepository.login(event.signInEntity);

    if (result is Sucess) {
      emitter(SucessSignInState);
    }

    if (result is Failure) {
      emitter(ErrorSignInState(errorMessage: result.exception.toString()));
    }
  }
}
