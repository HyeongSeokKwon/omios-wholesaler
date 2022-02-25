import 'package:deepy_wholesaler/bloc/auth_bloc/authentication_bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/home.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up.dart';
import 'package:deepy_wholesaler/repository/auth_repository.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String autoLoginIcon = "assets/images/svg/login.svg";
  String autoUnLoginIcon = "assets/images/svg/unlogin.svg";
  LoginController loginController = LoginController();
  AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    loginController.initLoginController(context).catchError((e) {
      showAlertDialog(context, e);
      setState(() {});
    });

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
    Scale.setScale(context);
    return BlocProvider(
      create: (context) => AuthenticationBloc(authRepository: authRepository),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.authStatus) {
              case AuthStatus.success:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
                break;
              case AuthStatus.failure:
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    const SnackBar(
                      content: Text('아이디 / 패스워드를 확인해주세요'),
                    ),
                  );
                break;
              case AuthStatus.loading:

              case AuthStatus.init:

              default:
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
                              const _LoginField(),
                              SizedBox(height: 16 * Scale.height),
                              _AutuLoginButton(
                                  loginController: loginController),
                              SizedBox(height: 16 * Scale.height),
                              const _LoginButton(),
                              SizedBox(height: 35 * Scale.height),
                              const _FindPrivacy(),
                              SizedBox(height: 160 * Scale.height),
                              const _SignUpButton(),
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

class MainText extends StatelessWidget {
  const MainText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 110 * Scale.height, left: 22 * Scale.width),
      child: Text("지금 당신의 쇼핑몰을\n책임지는 시간\nOMIOS",
          style: textStyle(
              const Color(0xff333333), FontWeight.w700, "NotoSansKR", 26.0)),
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _IdTextField(),
          SizedBox(height: 16 * Scale.height),
          _PasswordTextField(),
        ],
      ),
    );
  }
}

class _IdTextField extends StatelessWidget {
  final TextEditingController idTextController = TextEditingController();
  _IdTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0 * Scale.width),
          child: Stack(
            children: [
              SizedBox(
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                  ],
                  validator: (text) {
                    if (text!.trim().isNotEmpty && text.trim().length < 4) {
                      return "아이디는 4글자 이상 입력해주세요";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (text) {
                    context
                        .read<AuthenticationBloc>()
                        .add(ChangeIdEvent(id: text));
                  },
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  controller: idTextController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(
                      10 * Scale.width,
                      18 * Scale.height,
                      10 * Scale.width,
                      18 * Scale.height,
                    ),
                    counterText: "",
                    labelText: "아이디",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: TextStyle(
                      color: const Color(0xff666666),
                      height: 0.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14 * Scale.height,
                    ),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.clear,
                        color: const Color(0xff666666),
                        size: 20.0 * Scale.width,
                      ),
                      onPressed: () => idTextController.clear(),
                    ),
                    hintText: ("아이디를 입력하세요"),
                    hintStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.0),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PasswordTextField extends StatelessWidget {
  final TextEditingController pwdTextController = TextEditingController();
  _PasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 22.0 * Scale.width),
          child: Stack(
            children: [
              SizedBox(
                child: TextFormField(
                  showCursor: false,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                  ],
                  validator: (text) {
                    if (text!.trim().isNotEmpty && text.trim().length < 6) {
                      return "비밀번호는 6글자 이상 입력해주세요";
                    } else {
                      return null;
                    }
                  },
                  onChanged: ((value) {
                    context
                        .read<AuthenticationBloc>()
                        .add(ChangePasswordEvent(password: value));
                  }),
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  controller: pwdTextController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(
                      10 * Scale.width,
                      18 * Scale.height,
                      10 * Scale.width,
                      18 * Scale.height,
                    ),
                    labelStyle: TextStyle(
                      color: const Color(0xff666666),
                      height: 0.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14 * Scale.height,
                    ),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        Icons.clear,
                        color: const Color(0xff666666),
                        size: 20.0 * Scale.width,
                      ),
                      onPressed: () => pwdTextController.clear(),
                    ),
                    hintText: ("비밀번호를 입력하세요"),
                    hintStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.0),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(
                          color: Colors.grey[400]!, width: 1 * Scale.width),
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AutuLoginButton extends StatelessWidget {
  final LoginController loginController;
  const _AutuLoginButton({Key? key, required this.loginController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10 * Scale.width),
      child: GetBuilder<LoginController>(
          init: loginController,
          builder: (controller) {
            return SizedBox(
              height: 20 * Scale.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 0.7,
                    child: Switch.adaptive(
                        value: controller.isAutoLoginChecked ??= false,
                        onChanged: (value) => controller.checkedAutoLogin()),
                  ),
                  Text(
                    "자동로그인",
                    style: textStyle(const Color(0xff666666), FontWeight.w400,
                        "NotoSansKR", 14.0),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key? key}) : super(key: key);

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
              context.read<AuthenticationBloc>().state.authStatus =
                  AuthStatus.loading;
              context.read<AuthenticationBloc>().add(ClickLoginButtonEvent(
                  id: state.id, password: state.password));
            },
          ),
        );
      },
    );
  }
}

class _FindPrivacy extends StatelessWidget {
  const _FindPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const _FindId(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
          child: SizedBox(
            height: 15 * Scale.height,
            child: const VerticalDivider(
              color: Color(0xff999999),
            ),
          ),
        ),
        const _FindPassword(),
      ],
    );
  }
}

class _FindId extends StatelessWidget {
  const _FindId({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text("아이디 찾기",
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0)),
      onTap: () {
        Get.to(const Home());
      },
    );
  }
}

class _FindPassword extends StatelessWidget {
  const _FindPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text("비밀번호 찾기",
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0)),
      onTap: () {
        Get.to(const Home());
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12 * Scale.height),
      child: Center(
        child: TextButton(
          child: Text(
            "지금 회원가입하기!",
            style: textStyle(
                const Color(0xff666666), FontWeight.w500, "NotoSansKR", 16.0),
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
            Get.to(const SignUp());
          },
        ),
      ),
    );
  }
}
