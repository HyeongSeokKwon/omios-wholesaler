import 'package:deepy_wholesaler/page/signUp/sign_up_appbar.dart';
import 'package:deepy_wholesaler/page/signUp/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/util.dart';

class SignUpSecond extends StatefulWidget {
  final SignUpController signUpController;
  const SignUpSecond({Key? key, required this.signUpController})
      : super(key: key);

  @override
  _SignUpSecondState createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController pwdCheckController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SignUpAppBar(),
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              passwordArea(),
              passwordCheckArea(),
            ],
          ),
        ),
      ),
    );
  }

  Widget passwordArea() {
    return Padding(
      padding: EdgeInsets.only(
          top: 18 * Scale.width,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    style: textStyle(
                      const Color(0xff555555),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "비밀번호 "),
                TextSpan(
                    style: textStyle(
                      const Color(0xfff84457),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          Stack(
            children: [
              SizedBox(
                height: 60 * Scale.height,
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!-~]')),
                  ],
                  onChanged: (text) {
                    widget.signUpController.pwd = text;
                    widget.signUpController
                        .validatePassword(text, pwdController.text);
                  },
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  controller: pwdController,
                  obscureText: true,
                  decoration: InputDecoration(
                    counterText: "",
                    contentPadding: EdgeInsets.only(left: 12 * Scale.width),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: const TextStyle(
                      color: Color(0xff666666),
                      height: 0.6,
                      fontWeight: FontWeight.w400,
                      fontFamily: "NotoSansKR",
                      fontStyle: FontStyle.normal,
                      fontSize: 14.0,
                    ),
                    suffixIcon: GetBuilder<SignUpController>(
                        init: widget.signUpController,
                        builder: (controller) {
                          if (controller.isPwdValidate == "accept") {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/accept.svg"),
                              onPressed: () {},
                            );
                          } else if (controller.isPwdValidate == "deny") {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/deny.svg"),
                              onPressed: () {},
                            );
                          } else {
                            return IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.ac_unit,
                                size: 0,
                              ),
                            );
                          }
                        }),
                    hintText: ("비밀번호를 입력하세요"),
                    hintStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.0),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget passwordCheckArea() {
    return Padding(
      padding: EdgeInsets.only(
          top: 18 * Scale.height,
          left: 22 * Scale.width,
          right: 22 * Scale.width),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    style: textStyle(
                      const Color(0xff555555),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "비밀번호 확인 "),
                TextSpan(
                    style: textStyle(
                      const Color(0xfff84457),
                      FontWeight.w400,
                      "NotoSansKR",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          Stack(
            children: [
              SizedBox(
                height: 60 * Scale.height,
                child: TextFormField(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!-~]')),
                  ],
                  onChanged: (text) {
                    widget.signUpController.validateDuplicationCheck(
                        pwdController.text, pwdCheckController.text);
                  },
                  validator: (text) {
                    if (text!.trim().isNotEmpty && text.trim().length < 4) {
                      return "비밀번호는 10글자 이상 입력해주세요";
                    } else {
                      return null;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  maxLength: 30,
                  obscureText: true,
                  controller: pwdCheckController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12 * Scale.width),
                    counterText: "",
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelStyle: textStyle(
                      const Color(0xff666666),
                      FontWeight.w400,
                      "NotoSansKR",
                      14.0,
                    ),
                    suffixIcon: GetBuilder<SignUpController>(
                        init: widget.signUpController,
                        builder: (controller) {
                          if (controller.isPwdSame == "accept") {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/accept.svg"),
                              onPressed: () {},
                            );
                          } else if (controller.isPwdSame == "deny") {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/deny.svg"),
                              onPressed: () {},
                            );
                          } else {
                            return IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.ac_unit,
                                size: 0,
                              ),
                            );
                          }
                        }),
                    hintText: ("비밀번호를 입력하세요"),
                    hintStyle: textStyle(const Color(0xffcccccc),
                        FontWeight.w400, "NotoSansKR", 16.0),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      borderSide: BorderSide(
                          color: const Color(0xffcccccc),
                          width: 1 * Scale.width),
                    ),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
