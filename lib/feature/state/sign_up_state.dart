import 'package:under/feature/entities/entities.dart';

sealed class SignUpState {}

final class SignUpInitialState extends SignUpState {}

final class SignUpSucessState extends SignUpState {
  final UserModel userModel;

  SignUpSucessState({
    required this.userModel,
  });
}

final class SignUpLoadingState extends SignUpState {}

final class SignUpErrorState extends SignUpState {
  SignUpErrorState({required this.message});

  final String message;
}
