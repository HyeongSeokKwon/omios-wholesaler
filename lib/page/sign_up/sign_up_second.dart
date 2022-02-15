import 'package:deepy_wholesaler/page/sign_up/sign_up_appbar.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up_controller.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up_third.dart';
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
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController representativeNameController =
      TextEditingController();
  final TextEditingController idController = TextEditingController();
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
              businessNameArea(),
              representativeNameArea(),
              idArea(),
              passwordArea(),
              passwordCheckArea(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomSheetArea(),
    );
  }

  Widget businessNameArea() {
    return Column(
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
                  text: "상호명 "),
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4 * Scale.height),
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!-~]')),
            ],
            textInputAction: TextInputAction.next,
            maxLength: 30,
            controller: businessNameController,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.fromLTRB(
                10 * Scale.width,
                10 * Scale.height,
                10 * Scale.width,
                10 * Scale.height,
              ),
              labelStyle: const TextStyle(
                color: Color(0xff666666),
                height: 0.6,
                fontWeight: FontWeight.w400,
                fontFamily: "NotoSansKR",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
              hintText: ("상호를 입력하세요"),
              hintStyle: textStyle(
                  const Color(0xffcccccc), FontWeight.w400, "NotoSansKR", 16.0),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0 * Scale.width),
          child: Text(
            "영문상호 매장은 한글과 영문을 같이 입력해주세요.",
            style: textStyle(
              Colors.grey[400]!,
              FontWeight.w400,
              "NotoSansKR",
              11.0,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0 * Scale.width),
          child: Text(
            "ex) Omios 오미오스",
            style: textStyle(
              Colors.grey[400]!,
              FontWeight.w400,
              "NotoSansKR",
              11.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget representativeNameArea() {
    return Column(
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
                  text: "대표자 이름 "),
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
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4 * Scale.height),
          child: TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9!-~]')),
            ],
            textInputAction: TextInputAction.next,
            maxLength: 30,
            controller: representativeNameController,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.fromLTRB(
                10 * Scale.width,
                10 * Scale.height,
                10 * Scale.width,
                10 * Scale.height,
              ),
              labelStyle: const TextStyle(
                color: Color(0xff666666),
                height: 0.6,
                fontWeight: FontWeight.w400,
                fontFamily: "NotoSansKR",
                fontStyle: FontStyle.normal,
                fontSize: 14.0,
              ),
              hintText: ("대표자 성함을 입력하세요"),
              hintStyle: textStyle(
                  const Color(0xffcccccc), FontWeight.w400, "NotoSansKR", 16.0),
              border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                borderSide: BorderSide(
                    color: const Color(0xffcccccc), width: 1 * Scale.width),
              ),
            ),
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ],
    );
  }

  Widget idArea() {
    return Padding(
      padding: EdgeInsets.only(
        top: 18 * Scale.width,
      ),
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
                    text: "아이디 "),
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
                child: GetBuilder<SignUpController>(
                    init: widget.signUpController,
                    builder: (controller) {
                      return TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9!-~]')),
                        ],
                        onChanged: (text) {
                          controller.id = text;
                          controller.validateId(text);
                        },
                        textInputAction: TextInputAction.next,
                        maxLength: 30,
                        controller: idController,
                        decoration: InputDecoration(
                          counterText: "",
                          errorText: controller.passwordErrorType,
                          contentPadding: EdgeInsets.fromLTRB(
                            10 * Scale.width,
                            10 * Scale.height,
                            10 * Scale.width,
                            10 * Scale.height,
                          ),
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
                                if (controller.isIdDuplicated == "accept") {
                                  return IconButton(
                                    padding: EdgeInsets.zero,
                                    icon: SvgPicture.asset(
                                        "assets/images/svg/accept.svg"),
                                    onPressed: () {},
                                  );
                                } else if (controller.isIdDuplicated ==
                                    "deny") {
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
                          hintText: ("아이디를 입력하세요"),
                          hintStyle: textStyle(const Color(0xffcccccc),
                              FontWeight.w400, "NotoSansKR", 16.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      );
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget passwordArea() {
    return Padding(
      padding: EdgeInsets.only(
        top: 18 * Scale.width,
      ),
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
                child: GetBuilder<SignUpController>(
                    init: widget.signUpController,
                    builder: (controller) {
                      return TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9!-~]')),
                        ],
                        onChanged: (text) {
                          controller.pwd = text;
                          controller.validatePassword(
                              text, pwdCheckController.text);
                        },
                        textInputAction: TextInputAction.next,
                        maxLength: 30,
                        controller: pwdController,
                        obscureText: true,
                        decoration: InputDecoration(
                          counterText: "",
                          errorText: controller.passwordErrorType,
                          contentPadding: EdgeInsets.fromLTRB(
                            10 * Scale.width,
                            10 * Scale.height,
                            10 * Scale.width,
                            10 * Scale.height,
                          ),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(
                                color: const Color(0xffcccccc),
                                width: 1 * Scale.width),
                          ),
                        ),
                        textAlignVertical: TextAlignVertical.center,
                      );
                    }),
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
        top: 5 * Scale.height,
      ),
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
                    contentPadding: EdgeInsets.fromLTRB(
                      10 * Scale.width,
                      10 * Scale.height,
                      10 * Scale.width,
                      10 * Scale.height,
                    ),
                    counterText: "",
                    errorText: "",
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
                            icon:
                                SvgPicture.asset("assets/images/svg/deny.svg"),
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
                      },
                    ),
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

  Widget bottomSheetArea() {
    return InkWell(
      onTap: () {
        Get.to(SignUpThird(signUpController: widget.signUpController));
      },
      child: Container(
          height: 70 * Scale.height,
          color: Colors.indigo[500],
          child: Center(
            child: Text(
              "다음",
              style:
                  textStyle(Colors.white, FontWeight.w500, "NotoSansKR", 20.0),
            ),
          )),
    );
  }
}
