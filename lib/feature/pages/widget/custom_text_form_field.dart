import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
    this.controller,
    this.labelText, {
    Key? key,
    this.onTap,
    this.onChanged,
    this.isEmail = false,
    this.isCPF = false,
    this.numberOfLimitingText = 0,
    this.validator,
    this.isPassword = false,
  }) : super(key: key);

  final GestureTapCallback? onTap;
  final TextEditingController controller;
  final String labelText;
  final int numberOfLimitingText;
  final bool isPassword;
  final bool isCPF;
  final bool isEmail;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: isPassword,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      inputFormatters: _getLimitingText(),
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: labelText,
      ),
      validator: validator,
    );
  }

  List<TextInputFormatter>? _getLimitingText() {
    if (numberOfLimitingText <= 0) {
      return null;
    }

    if (isCPF) {
      return [
        FilteringTextInputFormatter.digitsOnly,
        CpfInputFormatter(),
      ];
    }

    return [LengthLimitingTextInputFormatter(numberOfLimitingText)];
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  }) {
    assert(mask != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator &&
            newValue.text.substring(newValue.text.length - 1) != separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
