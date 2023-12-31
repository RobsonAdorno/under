import 'package:flutter/material.dart';
import 'package:under/routers.dart';

import '../pages/page.dart';
import 'widget/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 250,
              height: 30,
              child: CustomButton(onPressed: () {
                Navigator.pushReplacementNamed(context, Routers.signIn);
              }, const Text('Login')),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 250,
              height: 30,
              child: CustomButton(onPressed: () {
                Navigator.pushReplacementNamed(context, Routers.signUp);
              }, const Text('Criar Conta')),
            ),
          ],
        )),
      ),
    );
  }
}
