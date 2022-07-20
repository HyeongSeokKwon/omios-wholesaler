import 'package:deepy_wholesaler/bloc/sign_up_bloc/user_info/user_info_bloc.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';
import '../../util/util.dart';
import 'sign_up_third.dart';

class SignUpSecond extends StatefulWidget {
  final StoreLocationBloc storeLocationBloc;
  const SignUpSecond({
    Key? key,
    required this.storeLocationBloc,
  }) : super(key: key);

  @override
  _SignUpSecondState createState() => _SignUpSecondState();
}

class _SignUpSecondState extends State<SignUpSecond> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController representativeNameController =
      TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController pwdCheckController = TextEditingController();
  late UserInfoBloc userInfoBloc;

  @override
  void initState() {
    super.initState();
    userInfoBloc = UserInfoBloc(widget.storeLocationBloc);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userInfoBloc,
      child: Scaffold(
        appBar: const SignUpAppBar(),
        backgroundColor: const Color(0xffffffff),
        body: GestureDetector(
          onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
          child: BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              if (context.read<UserInfoBloc>().state.fetchState ==
                  FetchState.error) {
                return networkErrorArea();
              } else {
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        businessNameArea(),
                        representativeNameArea(),
                        idArea(),
                        emailArea(),
                        passwordArea(),
                        passwordCheckArea(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: bottomSheetArea(),
      ),
    );
  }

  Widget networkErrorArea() {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "네트워크에 연결하지 못했어요",
                style: textStyle(
                    Colors.black, FontWeight.w700, "Pretendard", 20.0),
              ),
              Text(
                "네트워크 연결상태를 확인하고",
                style:
                    textStyle(Colors.grey, FontWeight.w500, "Pretendard", 13.0),
              ),
              Text(
                "다시 시도해 주세요",
                style:
                    textStyle(Colors.grey, FontWeight.w500, "Pretendard", 13.0),
              ),
              SizedBox(height: 15 * Scale.height),
              InkWell(
                onTap: () {
                  context
                      .read<UserInfoBloc>()
                      .add(CheckIdDuplicatedEvent(id: 'mockdata'));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadiusDirectional.all(
                          Radius.circular(19))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 17 * Scale.width,
                        vertical: 14 * Scale.height),
                    child: Text("다시 시도하기",
                        style: textStyle(Colors.grey[800]!, FontWeight.w500,
                            'Pretendard', 15.0)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
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
                    "Pretendard",
                    13.0,
                  ),
                  text: "상호명 "),
              TextSpan(
                  style: textStyle(
                    const Color(0xfff84457),
                    FontWeight.w400,
                    "Pretendard",
                    13.0,
                  ),
                  text: "*")
            ],
          ),
        ),
        BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4 * Scale.height),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[ㄱ-ㅎ가-힣a-zA-Z0-9!-~]')),
                ],
                onChanged: (text) {
                  context
                      .read<UserInfoBloc>()
                      .add(InputStoreNameEvent(storeName: text));
                },
                textInputAction: TextInputAction.next,
                maxLength: 40,
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
                    fontFamily: "Pretendard",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                  hintText: ("상호를 입력하세요"),
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "Pretendard", 16.0),
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
            );
          },
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0 * Scale.width),
          child: Text(
            "영문상호 매장은 한글과 영문을 같이 입력해주세요.",
            style: textStyle(
              Colors.grey[400]!,
              FontWeight.w400,
              "Pretendard",
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
              "Pretendard",
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
                    "Pretendard",
                    13.0,
                  ),
                  text: "대표자 이름 "),
              TextSpan(
                  style: textStyle(
                    const Color(0xfff84457),
                    FontWeight.w400,
                    "Pretendard",
                    13.0,
                  ),
                  text: "*")
            ],
          ),
        ),
        BlocBuilder<UserInfoBloc, UserInfoState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4 * Scale.height),
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"^[ㄱ-ㅎ가-힣]*$")),
                ],
                onChanged: (text) {
                  context
                      .read<UserInfoBloc>()
                      .add(InputRepresentativeNameEvent(name: text));
                },
                textInputAction: TextInputAction.next,
                maxLength: 60,
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
                    fontFamily: "Pretendard",
                    fontStyle: FontStyle.normal,
                    fontSize: 14.0,
                  ),
                  hintText: ("대표자 성함을 입력하세요"),
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "Pretendard", 16.0),
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
            );
          },
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
                      "Pretendard",
                      13.0,
                    ),
                    text: "아이디 "),
                TextSpan(
                    style: textStyle(
                      const Color(0xfff84457),
                      FontWeight.w400,
                      "Pretendard",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              String errorText;
              if (state.isIdEffective == ValidateState.unvalid) {
                errorText = "아이디는 영문 4~20글자 입니다 ";
              } else if (state.idUnique == ValidateState.unvalid) {
                errorText = "중복된 아이디가 존재합니다.";
              } else {
                errorText = "";
              }
              return Stack(
                children: [
                  SizedBox(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9!-~]')),
                      ],
                      onChanged: (text) {
                        context
                            .read<UserInfoBloc>()
                            .add(InputUsernameEvent(username: text));
                        context
                            .read<UserInfoBloc>()
                            .add(CheckIdDuplicatedEvent(id: idController.text));
                      },
                      textInputAction: TextInputAction.next,
                      maxLength: 30,
                      controller: idController,
                      decoration: InputDecoration(
                        counterText: "",
                        errorText: errorText,
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
                          fontFamily: "Pretendard",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                        suffixIcon: BlocBuilder<UserInfoBloc, UserInfoState>(
                          builder: ((context, state) {
                            if (context.read<UserInfoBloc>().state.idUnique ==
                                ValidateState.valid) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                    "assets/images/svg/accept.svg"),
                                onPressed: () {},
                              );
                            } else if (context
                                        .read<UserInfoBloc>()
                                        .state
                                        .idUnique ==
                                    ValidateState.unvalid ||
                                context
                                        .read<UserInfoBloc>()
                                        .state
                                        .isIdEffective ==
                                    ValidateState.unvalid) {
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
                        ),
                        hintText: ("아이디를 입력하세요"),
                        hintStyle: textStyle(const Color(0xffcccccc),
                            FontWeight.w400, "Pretendard", 16.0),
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
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget emailArea() {
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
                      "Pretendard",
                      13.0,
                    ),
                    text: "이메일 "),
                TextSpan(
                    style: textStyle(
                      const Color(0xfff84457),
                      FontWeight.w400,
                      "Pretendard",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9!-~]')),
                      ],
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (text) {
                        context
                            .read<UserInfoBloc>()
                            .add(InputEmailEvent(email: text));
                      },
                      textInputAction: TextInputAction.next,
                      maxLength: 50,
                      controller: emailController,
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
                          fontFamily: "Pretendard",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                        hintText: ("이메일을 입력하세요"),
                        hintStyle: textStyle(const Color(0xffcccccc),
                            FontWeight.w400, "Pretendard", 16.0),
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
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget passwordArea() {
    const String errorText = '비밀번호는 특수문자, 대문자, 소문자를 포함 10자 이상이어야 합니다.';
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
                      "Pretendard",
                      13.0,
                    ),
                    text: "비밀번호 "),
                TextSpan(
                    style: textStyle(
                      const Color(0xfff84457),
                      FontWeight.w400,
                      "Pretendard",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9!-~]')),
                      ],
                      onChanged: (text) {
                        context
                            .read<UserInfoBloc>()
                            .add(InputPasswordEvent(password: text));
                        context
                            .read<UserInfoBloc>()
                            .add(ValidatePasswordEvent(password: text));
                        if (pwdCheckController.text.isNotEmpty) {
                          context.read<UserInfoBloc>().add(CheckPasswordSame(
                              password: text,
                              passwordCheck: pwdCheckController.text));
                        }
                      },
                      textInputAction: TextInputAction.next,
                      maxLength: 30,
                      controller: pwdController,
                      obscureText: true,
                      decoration: InputDecoration(
                        counterText: "",
                        errorText: context
                                    .read<UserInfoBloc>()
                                    .state
                                    .isPasswordEffective ==
                                ValidateState.unvalid
                            ? errorText
                            : '',
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
                          fontFamily: "Pretendard",
                          fontStyle: FontStyle.normal,
                          fontSize: 14.0,
                        ),
                        suffixIcon: BlocBuilder<UserInfoBloc, UserInfoState>(
                            builder: (context, state) {
                          if (context
                                  .read<UserInfoBloc>()
                                  .state
                                  .isPasswordEffective ==
                              ValidateState.valid) {
                            return IconButton(
                              padding: EdgeInsets.zero,
                              icon: SvgPicture.asset(
                                  "assets/images/svg/accept.svg"),
                              onPressed: () {},
                            );
                          } else if (context
                                  .read<UserInfoBloc>()
                                  .state
                                  .isPasswordEffective ==
                              ValidateState.unvalid) {
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
                            FontWeight.w400, "Pretendard", 16.0),
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
                    ),
                  ),
                ],
              );
            },
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
                      "Pretendard",
                      13.0,
                    ),
                    text: "비밀번호 확인 "),
                TextSpan(
                    style: textStyle(
                      const Color(0xfff84457),
                      FontWeight.w400,
                      "Pretendard",
                      13.0,
                    ),
                    text: "*")
              ],
            ),
          ),
          SizedBox(
            height: 4 * Scale.height,
          ),
          BlocBuilder<UserInfoBloc, UserInfoState>(
            builder: (context, state) {
              return Stack(
                children: [
                  SizedBox(
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp('[a-zA-Z0-9!-~]')),
                      ],
                      onChanged: (text) {
                        context.read<UserInfoBloc>().add(CheckPasswordSame(
                            password: pwdController.text,
                            passwordCheck: pwdCheckController.text));
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
                          "Pretendard",
                          14.0,
                        ),
                        suffixIcon: BlocBuilder<UserInfoBloc, UserInfoState>(
                          builder: (context, state) {
                            if (context
                                    .read<UserInfoBloc>()
                                    .state
                                    .isPasswordSame ==
                                ValidateState.valid) {
                              return IconButton(
                                padding: EdgeInsets.zero,
                                icon: SvgPicture.asset(
                                    "assets/images/svg/accept.svg"),
                                onPressed: () {},
                              );
                            } else if (context
                                    .read<UserInfoBloc>()
                                    .state
                                    .isPasswordSame ==
                                ValidateState.unvalid) {
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
                          },
                        ),
                        hintText: ("비밀번호를 입력하세요"),
                        hintStyle: textStyle(const Color(0xffcccccc),
                            FontWeight.w400, "Pretendard", 16.0),
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
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget bottomSheetArea() {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (context.read<UserInfoBloc>().state.secondPageDataValid ==
                true) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => SignUpThird(
                            userInfoBloc: userInfoBloc,
                          ))));
            }
          },
          child: Container(
            height: 70 * Scale.height,
            color: context.read<UserInfoBloc>().state.secondPageDataValid
                ? Colors.indigo[500]
                : Colors.grey[350]!,
            child: Center(
              child: Text(
                "다음",
                style: textStyle(
                    Colors.white, FontWeight.w500, "Pretendard", 20.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
