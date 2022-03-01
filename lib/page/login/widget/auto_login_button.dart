import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';

class AutoLoginButton extends StatelessWidget {
  const AutoLoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
            padding: EdgeInsets.only(left: 10 * Scale.width),
            child: SizedBox(
              height: 20 * Scale.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Switch.adaptive(
                        value:
                            context.read<AuthenticationBloc>().state.autoLogin,
                        onChanged: ((newValue) {
                          context
                              .read<AuthenticationBloc>()
                              .add(ClickAutoLoginButtonEvent());
                        })),
                  ),
                  Text(
                    "자동로그인",
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
