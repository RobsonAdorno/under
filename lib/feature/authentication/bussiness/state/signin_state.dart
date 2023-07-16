sealed class SignInState {}

final class InitSignInState implements SignInState {}

final class LoadingSignInState implements SignInState {}

final class SucessSignInState implements SignInState {}

final class ErrorSignInState implements SignInState {
  String errorMessage;

  ErrorSignInState({required this.errorMessage});
}
