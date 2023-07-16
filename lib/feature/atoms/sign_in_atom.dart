import 'package:flutter/material.dart';
import 'package:under/feature/dto/dto.dart';
import 'package:under/feature/state/sign_in_state.dart';

///Atom
final singInState = ValueNotifier<SignInState>(SignInStart());

///Action
final fetchSignIn = ValueNotifier<SignInDTO>(SignInDTO());
