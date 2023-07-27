import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under/feature/api/token.dart';
import 'package:under/feature/authentication/bussiness/bloc/sign_in_bloc.dart';
import 'package:under/feature/home/injector.dart';

import '../../../../routers.dart';
import '../../../pages/authentication/signin.dart';
import '../../../pages/email_validator.dart';
import '../../../pages/widget/custom_button.dart';
import '../../../pages/widget/custom_text_form_field.dart';
import '../../bussiness/entity/sign_in.dart';
import '../../bussiness/event/signin_event.dart';
import '../../bussiness/state/signin_state.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key? key,
    required this.signInBloc,
  }) : super(key: key);
  final SignInBloc signInBloc;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => Injector.getIt.get<SignInBloc>(),
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Login'),
            ),
            body: BlocBuilder<SignInBloc, SignInState>(
              builder: (BuildContext context, SignInState state) {
                return switch (state) {
                  InitSignInState initState => Body(initState),
                  LoadingSignInState _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  SucessSignInState _ => Container(),
                  ErrorSignInState erroState => Body(erroState)
                };
              },
            )));
  }
}

class Body extends StatefulWidget {
  const Body(this.state, {Key? key}) : super(key: key);

  final SignInState state;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final TextEditingController textEditingControllerUsername =
      TextEditingController();

  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  final signInFormAction = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.state is ErrorSignInState) {
        final errorState = widget.state as ErrorSignInState;
        _showCustomDialog(context, errorState.errorMessage);
      }
    });
  }

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
                  onPressed: isValid
                      ? () async {
                          String? token = await Token.getToken();
                          final bloc = Injector.getIt.get<SignInBloc>();

                          final signinDTO = SignInEntity(
                              email: textEditingControllerUsername.text,
                              password: textEditingControllerPassword.text,
                              token: token!);

                          bloc.add(FetchLoginEvent(signInEntity: signinDTO));
                        }
                      : null,
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

  Widget teste(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routers.homeLogged);
    return Container();
  }

  void _showCustomDialog(BuildContext context, String errorDescription) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erro'),
          content: Text(errorDescription),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
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
