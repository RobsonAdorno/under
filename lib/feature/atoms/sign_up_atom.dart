import 'package:flutter/material.dart';
import 'package:under/feature/entities/entities.dart';
import 'package:under/feature/state/sign_up_state.dart';

///Atom
final signupState = ValueNotifier<SignUpState>(SignUpInitialState());

///Action
final signUpAction = ValueNotifier<UserModel>(UserModel());
final signUpFormAction = ValueNotifier<bool>(false);
