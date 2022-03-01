import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/home.dart';

import 'package:deepy_wholesaler/repository/auth_repository.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'widget/login_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String autoLoginIcon = "assets/images/svg/login.svg";
  String autoUnLoginIcon = "assets/images/svg/unlogin.svg";
  AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();

    getVibratePermission();
  }

  void getVibratePermission() async {
    try {
      await Vibrate.canVibrate;
    } on Exception catch (e) {
      showAlertDialog(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
          authRepository: AuthRepository(), initAutoLogin: false),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listenWhen: ((previous, current) =>
              previous.authStatus != current.authStatus),
          listener: (context, state) {
            switch (state.authStatus) {
              case AuthStatus.loginSuccess:
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => const Home(),
                    ),
                    (route) => false);
                break;
              case AuthStatus.loginFailure:
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('로그인 에러가 발생했습니다.')));
                break;
              default:
                break;
            }
          },
          builder: (context, state) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return Container(
                    color: const Color(0xffffffff),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const MainText(),
                          Column(
                            children: [
                              SizedBox(height: 50 * Scale.height),
                              const LoginField(),
                              SizedBox(height: 16 * Scale.height),
                              const AutoLoginButton(),
                              SizedBox(height: 16 * Scale.height),
                              const LoginButton(),
                              SizedBox(height: 35 * Scale.height),
                              const FindPrivacy(),
                              SizedBox(height: 160 * Scale.height),
                              const SignUpButton(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
