import 'package:flutter/material.dart';
import 'package:under/feature/atoms/sign_up_atom.dart';
import 'package:under/feature/entities/entities.dart';
import 'package:under/routers.dart';

import '../../state/sign_up_state.dart';
import '../page.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController textEditingControllerCPF =
      TextEditingController();

  final TextEditingController textEditingControllerName =
      TextEditingController();

  final TextEditingController textEditingControllerLastname =
      TextEditingController();

  final TextEditingController textEditingControllerEmail =
      TextEditingController();

  final TextEditingController textEditingControllerPassword =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar-se'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Form(
            onChanged: () {
              bool? isValid = _formKey.currentState?.validate();
              signUpFormAction.value = isValid ??= false;
            },
            key: _formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  textEditingControllerCPF,
                  isCPF: true,
                  'Digite o CPF',
                  numberOfLimitingText: 15,
                  validator: (String? cpf) {
                    if (cpf == null || cpf.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    if (cpf.length < 6) {
                      return 'Tem que ser maior que 6 caracteres';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  textEditingControllerName,
                  'Digite o primeiro nome',
                  numberOfLimitingText: 15,
                  validator: (String? nome) {
                    if (nome == null || nome.isEmpty) {
                      return 'Campo obrigatório';
                    }

                    if (nome.length < 6) {
                      return 'Tem que ser maior que 6 caracteres';
                    }

                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextFormField(
                  textEditingControllerEmail,
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
                  valueListenable: signUpFormAction,
                  builder: (BuildContext context, bool isValid, Widget? child) {
                    return CustomButton(
                      const Text('Entrar'),
                      onPressed: isValid ? _onClickButton() : null,
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Já tem uma conta? Faça o login'),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      child: const Text(
                        'aqui',
                        style: TextStyle(color: Colors.blue),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(context, Routers.signIn);
                      },
                    )
                  ],
                ),
                ListenableBuilder(
                  listenable: signupState,
                  builder: (BuildContext context, Widget? child) {
                    return switch (signupState.value) {
                      SignUpInitialState _ => Container(),
                      SignUpSucessState _ => Container(),
                      SignUpErrorState state => ErrorCustom(state.message),
                      SignUpLoadingState _ => const Center(
                          child: CircularProgressIndicator(),
                        )
                    };
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void Function()? _onClickButton() {
    return () {
      UserModel userModel = UserModel(
        cpf: textEditingControllerCPF.text,
        email: textEditingControllerEmail.text,
        name: textEditingControllerName.text,
        lastName: textEditingControllerLastname.text,
        password: textEditingControllerPassword.text,
      );

      signUpAction.value = userModel;
    };
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
    _showSnackBar();
  }

  _showSnackBar() {
    final snackBar = SnackBar(
      content: Text(widget.message),
      backgroundColor: const Color.fromARGB(255, 250, 19, 2),
    );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      signUpAction.value = UserModel();
    });
  }

  @override
  Widget build(BuildContext context) {
    _showSnackBar();
    signUpAction.value = UserModel();
    return Container();
  }
}

// class ErrorCustom {
//   const ErrorCustom(this._errorMessage);

//   final String _errorMessage;

//   void build(BuildContext context) {
//     SnackBar snackBar = SnackBar(
//       content: Text(_errorMessage),
//       backgroundColor: const Color.fromARGB(255, 250, 19, 2),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }
// }
