import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(this.child, {Key? key, this.onPressed}) : super(key: key);

  final void Function()? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Center(
          child: child,
        ));
  }
}
