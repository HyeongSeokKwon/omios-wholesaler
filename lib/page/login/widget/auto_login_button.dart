import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AutoLoginButton extends StatelessWidget {
  const AutoLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        print(context.read<AuthenticationBloc>().state.autoLogin);
        return Padding(
          padding: EdgeInsets.only(left: 22 * Scale.width),
          child: InkWell(
            child: SizedBox(
              height: 20 * Scale.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20 * Scale.width,
                    height: 20 * Scale.width,
                    child: context.read<AuthenticationBloc>().state.autoLogin
                        ? SvgPicture.asset(
                            "assets/images/svg/autoLoginActive.svg")
                        : SvgPicture.asset("assets/images/svg/autoLogin.svg"),
                  ),
                  SizedBox(
                    width: 10 * Scale.width,
                  ),
                  Text(
                    "자동로그인",
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                ],
              ),
            ),
            onTap: () {
              context
                  .read<AuthenticationBloc>()
                  .add(ClickAutoLoginButtonEvent());
            },
          ),
        );
      },
    );
  }
}
