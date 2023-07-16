import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under/feature/authentication/bussiness/bloc/sign_in_bloc.dart';

import '../../../../routers.dart';
import '../../../pages/authentication/signin.dart';
import '../../../pages/email_validator.dart';
import '../../../pages/widget/custom_button.dart';
import '../../../pages/widget/custom_text_form_field.dart';
import '../../bussiness/entity/sign_in.dart';
import '../../bussiness/state/signin_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
    required this.signInBloc,
  }) : super(key: key);
  final SignInBloc signInBloc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: BlocBuilder<SignInBloc, SignInState>(
          builder: (context, state) {
            return switch (state) {
              InitSignInState _ => Body(),
              LoadingSignInState _ => const Center(
                  child: CircularProgressIndicator(),
                ),
              SucessSignInState _ => Container(),
              ErrorSignInState errorState =>
                ErrorCustom(errorState.errorMessage),
            };
          },
        ));
  }
}

class Body extends StatelessWidget {
  Body({Key? key}) : super(key: key);

  final TextEditingController textEditingControllerUsername =
      TextEditingController();
  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  final signInFormAction = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Form(
        onChanged: () {
          bool? isValid = _formKey.currentState?.validate();
          signInFormAction.value = isValid ??= false;
        },
        key: _formKey,
        child: Column(
          children: [
            CustomTextFormField(
              textEditingControllerUsername,
              'Digite o e-mail',
              numberOfLimitingText: 40,
              isEmail: true,
              validator: (String? email) {
                if (email == null || email.isEmpty) {
                  return 'Campo obrigatório';
                }

                if (email.length < 6) {
                  return 'Tem que ser maior que 6 caracteres';
                }

                if (!EmailValidator.validate(email)) {
                  return 'E-mail inválido';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              textEditingControllerPassword,
              isPassword: true,
              'Digite a senha',
              numberOfLimitingText: 15,
              validator: (String? password) {
                if (password == null || password.isEmpty) {
                  return 'Campo obrigatório';
                }

                if (password.length < 6) {
                  return 'Senha tem que ser maior que 6 caracteres';
                }

                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              valueListenable: signInFormAction,
              builder: (BuildContext context, bool isValid, Widget? child) {
                return CustomButton(
                  const Text('Entrar'),
                  onPressed: isValid ? _onClickButton() : null,
                );
              },
            ),
            const Row(
              children: [
                Text('Ainda não é cadastrado?'),
                SizedBox(
                  width: 10,
                ),
                LinkText(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void Function()? _onClickButton() {
    return () {
      final signinDTO = SignInEntity(
        username: textEditingControllerUsername.text,
        password: textEditingControllerPassword.text,
      );
    };
  }

  Widget teste(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routers.homeLogged);
    return Container();
  }
}

class ErrorCustom extends StatefulWidget {
  const ErrorCustom(this.message, {Key? key}) : super(key: key);

  final String message;

  @override
  State<ErrorCustom> createState() => _ErrorCustomState();
}

class _ErrorCustomState extends State<ErrorCustom> {
  @override
  void initState() {
    super.initState();
    // _showSnackBar();
  }

  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text(widget.message),
      backgroundColor: const Color.fromARGB(255, 250, 19, 2),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    _showSnackBar();

    return Container();
  }
}
