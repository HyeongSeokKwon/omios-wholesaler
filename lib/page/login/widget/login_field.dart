import 'package:deepy_wholesaler/page/login/widget/id_field.dart';
import 'package:deepy_wholesaler/page/login/widget/password_field.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          IdTextField(),
          SizedBox(height: 16 * Scale.height),
          PasswordTextField(),
        ],
      ),
    );
  }
}
