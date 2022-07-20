import 'package:deepy_wholesaler/page/sign_up/sign_up.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * Scale.height),
      child: Center(
        child: TextButton(
          child: Text(
            "지금 회원가입하기!",
            style: textStyle(
                const Color(0xff666666), FontWeight.w500, "Pretendard", 15.0),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: const BorderSide(color: Color(0xffe2e2e2)),
              ),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
              Size(370 * Scale.width, 56 * Scale.height),
            ),
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUp()));
          },
        ),
      ),
    );
  }
}
