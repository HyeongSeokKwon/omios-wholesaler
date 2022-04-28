import 'package:deepy_wholesaler/page/sign_up/sign_up_appbar.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/bloc.dart';
import '../../bloc/sign_up_bloc/user_info/user_info_bloc.dart';

class SignUpThird extends StatelessWidget {
  final UserInfoBloc userInfoBloc;
  const SignUpThird({Key? key, required this.userInfoBloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: userInfoBloc,
      child: GestureDetector(
        child: Scaffold(
            appBar: const SignUpAppBar(),
            backgroundColor: const Color(0xffffffff),
            resizeToAvoidBottomInset: false,
            body: BlocBuilder<UserInfoBloc, UserInfoState>(
              builder: (context, state) {
                if (context.read<UserInfoBloc>().state.fetchState ==
                    FetchState.error) {
                  return networkErrorArea();
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        storeNumberArea(context),
                        phoneNumberArea(),
                        companyRegistrationNumberArea(context),
                        pictureArea(context),
                        termsArea(),
                      ],
                    ),
                  );
                }
              },
            ),
            bottomNavigationBar: bottomSheetArea()),
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
                    Colors.black, FontWeight.w700, "NotoSansKR", 20.0),
              ),
              Text(
                "네트워크 연결상태를 확인하고",
                style:
                    textStyle(Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
              ),
              Text(
                "다시 시도해 주세요",
                style:
                    textStyle(Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
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
                            'NotoSansKR', 15.0)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget storeNumberArea(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        String errorText = "";
        if (context.read<UserInfoBloc>().state.isStoreNumberEffective ==
            ValidateState.unvalid) {
          errorText = "올바르지 않은 전화번호 형식입니다.";
        } else {
          errorText = "";
        }
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
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
                        text: "매장 전화번호 "),
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
              Row(
                children: [
                  SizedBox(
                    width: 210 * Scale.width,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      initialValue:
                          context.read<UserInfoBloc>().state.storeNumber,
                      maxLength: 11,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      showCursor: false,
                      onChanged: (text) {
                        context.read<UserInfoBloc>().add(InputStoreNumberEvent(
                              storeNumber: text,
                            ));
                        context
                            .read<UserInfoBloc>()
                            .add(ValidateStoreNumberEvent(text));
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          10 * Scale.width,
                          10 * Scale.height,
                          10 * Scale.width,
                          10 * Scale.height,
                        ),
                        counterText: "",
                        errorText: errorText,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: TextStyle(
                          color: const Color(0xff666666),
                          height: 0.6,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansKR",
                          fontStyle: FontStyle.normal,
                          fontSize: 14 * Scale.height,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Color(0xffcccccc), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Color(0xffcccccc), width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
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
                    ),
                  ),
                  SizedBox(width: 5 * Scale.width),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget phoneNumberArea() {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        String errorText = "";
        if (context.read<UserInfoBloc>().state.isPhoneNumberEffective ==
            ValidateState.unvalid) {
          errorText = "올바르지 않은 휴대폰 번호 형식입니다.";
        } else {
          errorText = "";
        }
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
                      text: "휴대폰 번호 "),
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
            Row(
              children: [
                Flexible(
                  child: SizedBox(
                    width: 230 * Scale.width,
                    height: 40,
                    child: TextFormField(
                      maxLength: 11,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      showCursor: false,
                      initialValue:
                          context.read<UserInfoBloc>().state.phoneNumber,
                      onChanged: (text) {
                        context
                            .read<UserInfoBloc>()
                            .add(InputPhoneNumberEvent(phoneNumber: text));
                        context
                            .read<UserInfoBloc>()
                            .add(ValidatePhoneNumberEvent(phoneNumber: text));
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          10 * Scale.width,
                          10 * Scale.height,
                          10 * Scale.width,
                          10 * Scale.height,
                        ),
                        counterText: "",
                        //errorText: errorText,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: TextStyle(
                          color: const Color(0xff666666),
                          height: 0.6,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansKR",
                          fontStyle: FontStyle.normal,
                          fontSize: 14 * Scale.height,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Color(0xffcccccc), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Color(0xffcccccc), width: 1),
                        ),
                        errorBorder: OutlineInputBorder(
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
                ),
                SizedBox(width: 3 * Scale.width),
                Flexible(
                  child: TextButton(
                    child: Text("인증번호 발송",
                        style: textStyle(
                            Colors.white, FontWeight.w500, "NotoSansKR", 14.0)),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      fixedSize: MaterialStateProperty.all<Size>(
                          Size(105 * Scale.width, 40 * Scale.height)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color(0xffec5363)),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            errorText.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: EdgeInsets.only(bottom: 8 * Scale.height),
                    child: Text(errorText,
                        style: textStyle(
                            Colors.red, FontWeight.w400, "NotoSansKR", 12.0)),
                  ),
            TextField(
              maxLength: 11,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              showCursor: false,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(
                  10 * Scale.width,
                  10 * Scale.height,
                  10 * Scale.width,
                  10 * Scale.height,
                ),
                counterText: "",
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                labelStyle: TextStyle(
                  color: const Color(0xff666666),
                  height: 0.6,
                  fontWeight: FontWeight.w400,
                  fontFamily: "NotoSansKR",
                  fontStyle: FontStyle.normal,
                  fontSize: 14 * Scale.height,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  borderSide: BorderSide(color: Color(0xffcccccc), width: 1),
                ),
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 3 * Scale.height),
            Text("휴대폰 번호를 입력하신 후 인증번호 받기 버튼을 눌러주세요,",
                style: textStyle(
                    Colors.grey[400]!, FontWeight.w500, 'NotoSansKR', 11.0))
          ],
        );
      },
    );
  }

  Widget companyRegistrationNumberArea(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
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
                        text: "사업자 등록 번호 "),
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
              Row(
                children: [
                  SizedBox(
                    width: 190 * Scale.width,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      showCursor: false,
                      onChanged: (text) {
                        context.read<UserInfoBloc>().add(
                            InputCompanyRegistrationNumberEvent(number: text));
                        if (text.length == 10) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(
                          10 * Scale.width,
                          10 * Scale.height,
                          10 * Scale.width,
                          10 * Scale.height,
                        ),
                        counterText: "",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        labelStyle: TextStyle(
                          color: const Color(0xff666666),
                          height: 0.6,
                          fontWeight: FontWeight.w400,
                          fontFamily: "NotoSansKR",
                          fontStyle: FontStyle.normal,
                          fontSize: 14 * Scale.height,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Color(0xffcccccc), width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide:
                              BorderSide(color: Color(0xffcccccc), width: 1),
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
      },
    );
  }

  Widget pictureArea(BuildContext context) {
    return BlocBuilder<UserInfoBloc, UserInfoState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
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
                        text: "사업자 등록번호 사진 "),
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
              InkWell(
                onTap: () {
                  final userInfoBloc = BlocProvider.of<UserInfoBloc>(context);
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    )),
                    context: context,
                    builder: (BuildContext bc) {
                      return BlocProvider.value(
                        value: userInfoBloc,
                        child: BlocBuilder<UserInfoBloc, UserInfoState>(
                          builder: (context, state) {
                            return SafeArea(
                              child: SizedBox(
                                child: Wrap(
                                  children: <Widget>[
                                    ListTile(
                                        leading:
                                            const Icon(Icons.photo_library),
                                        title: const Text('앨범에서 가져오기'),
                                        onTap: () {
                                          context
                                              .read<UserInfoBloc>()
                                              .add(GetImageFromGallery());
                                          Navigator.of(context).pop();
                                        }),
                                    ListTile(
                                      leading: const Icon(Icons.photo_camera),
                                      title: const Text('사진 찍기'),
                                      onTap: () {
                                        context
                                            .read<UserInfoBloc>()
                                            .add(GetImageFromCamera());
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: BlocBuilder<UserInfoBloc, UserInfoState>(
                  builder: (context, state) {
                    return Container(
                        height: 200 * Scale.height,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: context
                                    .read<UserInfoBloc>()
                                    .state
                                    .companyRegistrationImage ==
                                null
                            ? SvgPicture.asset(
                                "assets/images/svg/searchImage.svg",
                                fit: BoxFit.scaleDown,
                              )
                            : Image.file(context
                                .read<UserInfoBloc>()
                                .state
                                .companyRegistrationImage!));
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget bottomSheetArea() {
    return BlocConsumer<UserInfoBloc, UserInfoState>(
      listener: ((context, state) {
        if (context.read<UserInfoBloc>().state.signUpState ==
            RequestState.failure) {
          final userInfoBloc = BlocProvider.of<UserInfoBloc>(context);
          showDialog(
            context: context,
            builder: (context) {
              return BlocProvider.value(
                value: userInfoBloc,
                child: AlertDialog(
                  content: Text(
                    userInfoBloc.state.signUpErrorType,
                    style: textStyle(
                        Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text(
                        "확인",
                        style: textStyle(
                            Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            },
          );
          // showAlertDialog(
          //     context, context.read<UserInfoBloc>().state.signUpErrorType);
        }
      }),
      builder: (context, state) {
        return InkWell(
          onTap: () {
            if (context.read<UserInfoBloc>().state.thirdPageDataValid) {
              context.read<UserInfoBloc>().add(ClickSignUpButtonEvent());
            }
          },
          child: Container(
            height: 70 * Scale.height,
            color: context.read<UserInfoBloc>().state.thirdPageDataValid
                ? Colors.indigo[500]
                : Colors.grey[400],
            child: Center(
              child: Text(
                "완료",
                style: textStyle(
                    Colors.white, FontWeight.w500, "NotoSansKR", 20.0),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget termsArea() {
    return Column(
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
                  text: "약관 동의 "),
              TextSpan(
                  style: textStyle(
                    const Color(0xfff84457),
                    FontWeight.w400,
                    "NotoSansKR",
                    13.0,
                  ),
                  text: "*"),
            ],
          ),
        ),
      ],
    );
  }
}
