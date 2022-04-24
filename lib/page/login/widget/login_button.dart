import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Center(
          child: TextButton(
            child: Text("로그인",
                style: textStyle(
                    Colors.white, FontWeight.w400, "NotoSansKR", 16.0)),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              fixedSize: MaterialStateProperty.all<Size>(
                  Size(370 * Scale.width, 60 * Scale.height)),
              backgroundColor:
                  MaterialStateProperty.all<Color>(const Color(0xffec5363)),
            ),
            onPressed: () {
              try {
                context.read<AuthenticationBloc>().add(ClickLoginButtonEvent(
                    id: state.id, password: state.password));
              } catch (e) {}
            },
          ),
        );
      },
    );
  }
}
