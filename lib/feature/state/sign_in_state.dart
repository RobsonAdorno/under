import '../dto/dto.dart';

sealed class SignInState {}

final class SignInStart implements SignInState {}

final class SignInLoading implements SignInState {}

final class SignInFetch implements SignInState {
  final SignInDTO signIn;

  SignInFetch(this.signIn);
}

final class SignInError implements SignInState {
  final String message;
  SignInError(this.message);
}
