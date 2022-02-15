import 'package:deepy_wholesaler/page/sign_up/sign_up_appbar.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up_controller.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SignUpThird extends StatelessWidget {
  final SignUpController signUpController;
  const SignUpThird({required this.signUpController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SignUpAppBar(),
        backgroundColor: const Color(0xffffffff),
        body: Padding(
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
        ),
        bottomNavigationBar: bottomSheetArea());
  }

  Widget storeNumberArea(BuildContext context) {
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
                width: 80 * Scale.width,
                child: TextField(
                  maxLength: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  showCursor: false,
                  onChanged: (text) {
                    if (text.length == 3) {
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
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 5 * Scale.width),
              SizedBox(
                width: 80 * Scale.width,
                child: TextField(
                  maxLength: 4,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  showCursor: false,
                  onChanged: (text) {
                    if (text.length == 4) {
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
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 5 * Scale.width),
              SizedBox(
                width: 80 * Scale.width,
                child: TextField(
                  maxLength: 4,
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
                      borderSide:
                          BorderSide(color: Color(0xffcccccc), width: 1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide:
                          BorderSide(color: Color(0xffcccccc), width: 1),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget phoneNumberArea() {
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
              SizedBox(
                width: 200 * Scale.width,
                height: 40 * Scale.width,
                child: TextField(
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
              SizedBox(width: 3 * Scale.width),
              TextButton(
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
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xffec5363)),
                ),
                onPressed: () {},
              ),
            ],
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
      ),
    );
  }

  Widget companyRegistrationNumberArea(BuildContext context) {
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
                width: 60 * Scale.width,
                child: TextField(
                  maxLength: 3,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  showCursor: false,
                  onChanged: (text) {
                    if (text.length == 3) {
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
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 5 * Scale.width),
              SizedBox(
                width: 50 * Scale.width,
                child: TextField(
                  maxLength: 2,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  showCursor: false,
                  onChanged: (text) {
                    if (text.length == 2) {
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
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 5 * Scale.width),
              SizedBox(
                width: 80 * Scale.width,
                child: TextField(
                  maxLength: 5,
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
                      borderSide:
                          BorderSide(color: Color(0xffcccccc), width: 1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                      borderSide:
                          BorderSide(color: Color(0xffcccccc), width: 1),
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget pictureArea(BuildContext context) {
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
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
                context: context,
                builder: (BuildContext bc) {
                  return SafeArea(
                    child: Container(
                      child: Wrap(
                        children: <Widget>[
                          ListTile(
                              leading: const Icon(Icons.photo_library),
                              title: const Text('앨범에서 가져오기'),
                              onTap: () {
                                signUpController.getImageFromGallery();
                                Navigator.of(context).pop();
                              }),
                          ListTile(
                            leading: const Icon(Icons.photo_camera),
                            title: const Text('사진 찍기'),
                            onTap: () {
                              signUpController.getImageFromCamera();
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: GetBuilder<SignUpController>(
              id: 'imageArea',
              init: signUpController,
              builder: (controller) {
                return Container(
                    height: 200 * Scale.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(7),
                      ),
                    ),
                    child: controller.businessRegistNumPhoto ??
                        SvgPicture.asset(
                          "assets/images/svg/searchImage.svg",
                          fit: BoxFit.scaleDown,
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheetArea() {
    return InkWell(
      onTap: () {
        //Get.to(SignUpSecond(signUpController: signUpController));
      },
      child: Container(
        height: 70 * Scale.height,
        color: Colors.indigo[500],
        child: Center(
          child: Text(
            "완료",
            style: textStyle(Colors.white, FontWeight.w500, "NotoSansKR", 20.0),
          ),
        ),
      ),
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
