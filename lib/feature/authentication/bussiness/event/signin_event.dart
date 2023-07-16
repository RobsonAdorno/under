import 'package:under/feature/authentication/bussiness/entity/sign_in.dart';

sealed class SignInEvent {}

final class FetchLoginEvent implements SignInEvent {
  SignInEntity signInEntity;

  FetchLoginEvent({required this.signInEntity});
}
