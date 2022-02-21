import 'package:deepy_wholesaler/page/deepy_home/home.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  String autoLoginIcon = "assets/images/svg/login.svg";
  String autoUnLoginIcon = "assets/images/svg/unlogin.svg";
  LoginController loginController = LoginController();
  TextEditingController idTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();

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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          color: const Color(0xffffffff),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 지금 당신의 쇼핑몰을  책임지는 시간 Deepy
                _buildMainText(),
                Column(
                  children: [
                    SizedBox(height: 50 * Scale.height),
                    _buildLoginField(),
                    SizedBox(height: 16 * Scale.height),
                    _buildAutoLogin(),
                    SizedBox(height: 26 * Scale.height),
                    _buildLoginButton(),
                    SizedBox(height: 20 * Scale.height),
                    _buildFindArea(),
                    SizedBox(height: 190 * Scale.height),
                    _buildSignInButton()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainText() {
    return Padding(
      padding: EdgeInsets.only(top: 110 * Scale.height, left: 22 * Scale.width),
      child: Text("지금 당신의 쇼핑몰을\n책임지는 시간\nDeepy",
          style: textStyle(
              const Color(0xff333333), FontWeight.w700, "NotoSansKR", 28.0)),
    );
  }

  Widget _buildLoginField() {
    return Form(
      key: _formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          _buildIdField(),
          SizedBox(height: 16 * Scale.height),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildIdField() {
    final TextEditingController textController = idTextController;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.0 * Scale.width),
      child: Stack(
        children: [
          SizedBox(
            // height: 71.0 * Scale.height,
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
                setState(() {});
              },
              textInputAction: TextInputAction.next,
              maxLength: 30,
              controller: textController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(
                  10 * Scale.width,
                  22 * Scale.height,
                  10 * Scale.width,
                  22 * Scale.height,
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
                  onPressed: () => textController.clear(),
                ),
                hintText: ("아이디를 입력하세요"),
                hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                    "NotoSansKR", 16.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField() {
    final TextEditingController textController = pwdTextController;
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
                if (text!.trim().isNotEmpty && text.trim().length < 4) {
                  return "비밀번호는 6글자 이상 입력해주세요";
                } else {
                  return null;
                }
              },
              textInputAction: TextInputAction.next,
              maxLength: 30,
              controller: textController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "비밀번호",
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(
                  10 * Scale.width,
                  22 * Scale.height,
                  10 * Scale.width,
                  22 * Scale.height,
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
                  onPressed: () => textController.clear(),
                ),
                hintText: ("비밀번호를 입력하세요"),
                hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                    "NotoSansKR", 16.0),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(14)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
              ),
              textAlignVertical: TextAlignVertical.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAutoLogin() {
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

  Widget _buildLoginButton() {
    bool isLoginSuccess;

    return Center(
      child: TextButton(
        child: Text("로그인",
            style:
                textStyle(Colors.white, FontWeight.w400, "NotoSansKR", 16.0)),
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
        onPressed: () async {
          try {
            isLoginSuccess = await loginController.loginButtonPressed(
                idTextController.text, pwdTextController.text);

            if (isLoginSuccess) {
              Get.to(() => const Home());
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("아이디,패스워드를 확인해주세요"),
                ),
              );
            }
          } on Exception catch (e) {
            showAlertDialog(context, e.toString());
          }
        },
      ),
    );
  }

  Widget _buildFindArea() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFindPrivacy("아이디 찾기"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
          child: SizedBox(
            height: 15 * Scale.height,
            child: const VerticalDivider(
              color: Color(0xff999999),
            ),
          ),
        ),
        _buildFindPrivacy("비밀번호 찾기")
      ],
    );
  }

  Widget _buildFindPrivacy(String findTarget) {
    return InkWell(
      child: Text(findTarget,
          style: textStyle(
              const Color(0xff999999), FontWeight.w400, "NotoSansKR", 14.0)),
      onTap: () {
        Get.to(const Home());
        if (findTarget == "아이디 찾기") {
          //아이디 찾기에 따른 로직
        } else {
          //비밀번호 찾기에 따른 로직
        }
      },
    );
  }

  Widget _buildSignInButton() {
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
