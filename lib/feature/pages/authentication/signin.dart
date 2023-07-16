import 'package:flutter/material.dart';
import 'package:under/feature/atoms/sign_in_atom.dart';
import 'package:under/feature/dto/dto.dart';
import 'package:under/feature/mixins/auth_validate_mixin.dart';
import 'package:under/routers.dart';

import '../../state/sign_in_state.dart';
import '../page.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key) {
    singInState.value = SignInStart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget with AuthValidateMixin {
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
            ListenableBuilder(
              listenable: singInState,
              builder: (BuildContext context, Widget? child) {
                return switch (singInState.value) {
                  SignInStart _ => const SizedBox(),
                  SignInLoading _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  SignInFetch _ => teste(context),
                  SignInError state => ErrorCustom(state.message),
                };
              },
            )
          ],
        ),
      ),
    );
  }

  void Function()? _onClickButton() {
    return () {
      final signinDTO = SignInDTO(
        username: textEditingControllerUsername.text,
        password: textEditingControllerPassword.text,
      );

      fetchSignIn.value = signinDTO;
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

class LinkText extends StatelessWidget {
  const LinkText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: const Text(
        'Cadastrar-se',
        style: TextStyle(color: Colors.blue),
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(Routers.signUp);
      },
    );
  }
}
