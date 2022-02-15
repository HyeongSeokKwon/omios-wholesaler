import 'package:deepy_wholesaler/page/sign_up/sign_up_appbar.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up_controller.dart';
import 'package:deepy_wholesaler/page/sign_up/sign_up_second.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/util.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpController signUpController = SignUpController();
  TextEditingController floorTextController = TextEditingController();
  TextEditingController roomTextController = TextEditingController();
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
              selectBuildingArea(),
              selectFloorArea(),
              inputRoomNumberArea(),
              questionArea(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomSheetArea(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget selectBuildingArea() {
    List<String> buildingName = [
      "디오트",
      "청평화",
      "누존",
      "APM",
      "AAA",
      "BBB",
      "CCC"
    ];
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            isDismissible: false,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            context: context,
            builder: (context) => Stack(
              children: [
                GestureDetector(
                  child: Container(
                      width: 414 * Scale.width,
                      height: 896 * Scale.height,
                      color: Colors.transparent),
                  onTap: Navigator.of(context).pop,
                ),
                Positioned(
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.6,
                    maxChildSize: 1.0,
                    builder: (_, controller) {
                      return Stack(children: [
                        Container(
                          width: 414 * Scale.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 22 * Scale.width),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 25 * Scale.height,
                                      bottom: 30 * Scale.height),
                                  child: Text("건물명 선택",
                                      style: textStyle(const Color(0xff333333),
                                          FontWeight.w700, "NotoSansKR", 21.0)),
                                ),
                                Expanded(
                                  child: Center(
                                      child: GetBuilder<SignUpController>(
                                          init: signUpController,
                                          builder: (controller) {
                                            return ListView.separated(
                                              itemCount: buildingName.length,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Divider();
                                              },
                                              itemBuilder: ((context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    controller.clickedBuilding(
                                                        buildingName[index]);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: SizedBox(
                                                    height: 70 * Scale.height,
                                                    width: double.infinity,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          buildingName[index],
                                                          style: textStyle(
                                                              Colors.black,
                                                              FontWeight.w300,
                                                              "NotoSansKR",
                                                              19.0),
                                                        ),
                                                        controller.selectedBuilding ==
                                                                buildingName[
                                                                    index]
                                                            ? SvgPicture.asset(
                                                                "assets/images/svg/accept.svg")
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            );
                                          })),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]);
                    },
                  ),
                )
              ],
            ),
          );
        },
        child: GetBuilder<SignUpController>(
            init: signUpController,
            builder: (controller) {
              return Container(
                height: 150 * Scale.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5 * Scale.width,
                    color: controller.selectedBuilding != ""
                        ? const Color.fromARGB(255, 56, 218, 61)
                        : Colors.grey[400]!,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15 * Scale.width),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35 * Scale.width,
                        backgroundColor: Colors.blue[100]!,
                        child: const Icon(Icons.add_box_outlined),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15 * Scale.width, right: 20 * Scale.width),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "건물 선택",
                              style: textStyle(Colors.black, FontWeight.w700,
                                  "NotoSansKR", 19.0),
                            ),
                            Text("STEP 1. 건물을 선택해주세요",
                                style: textStyle(Colors.grey[400]!,
                                    FontWeight.w500, "NotoSansKR", 14.0))
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget selectFloorArea() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                  ),
                ),
                width: 414 * Scale.width,
                height: 150 * Scale.height,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 22 * Scale.width,
                      right: 22 * Scale.width,
                      top: 20 * Scale.width),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("층수 입력",
                          style: textStyle(Colors.black, FontWeight.w700,
                              "NotoSansKR", 19.0)),
                      SizedBox(height: 10 * Scale.height),
                      TextField(
                        autofocus: false,
                        onChanged: (String value) {},
                        onSubmitted: (String value) async {
                          signUpController.clickedfloor(value);
                          Navigator.of(context).pop();
                        },
                        showCursor: false,
                        controller: floorTextController,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(11 * Scale.width),
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: Colors.grey[100]!, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: Colors.grey[100]!, width: 1),
                            ),
                            hintText: ' 층수를 입력해주세요'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: GetBuilder<SignUpController>(
            init: signUpController,
            builder: (controller) {
              return Container(
                height: 150 * Scale.height,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5 * Scale.width,
                    color: controller.selectedFloor.isEmpty
                        ? Colors.grey[400]!
                        : const Color.fromARGB(255, 56, 218, 61),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15 * Scale.width),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35 * Scale.width,
                        backgroundColor: Colors.blue[100]!,
                        child: const Icon(Icons.add_box_outlined),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 15 * Scale.width, right: 20 * Scale.width),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "층 입력",
                              style: textStyle(Colors.black, FontWeight.w700,
                                  "NotoSansKR", 19.0),
                            ),
                            Text("STEP 2. 층수를 입력해주세요",
                                style: textStyle(Colors.grey[400]!,
                                    FontWeight.w500, "NotoSansKR", 14.0))
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_right_sharp,
                        size: 40,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget inputRoomNumberArea() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10 * Scale.height),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
            isDismissible: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                  ),
                ),
                width: 414 * Scale.width,
                height: 150 * Scale.height,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 22 * Scale.width,
                      right: 22 * Scale.width,
                      top: 20 * Scale.width),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("호수 입력",
                          style: textStyle(Colors.black, FontWeight.w700,
                              "NotoSansKR", 19.0)),
                      SizedBox(height: 10 * Scale.height),
                      TextField(
                        autofocus: false,
                        onChanged: (String value) {},
                        onSubmitted: (String value) async {
                          signUpController.clickedRoom(value);
                          Navigator.of(context).pop();
                        },
                        showCursor: false,
                        controller: roomTextController,
                        decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.all(11 * Scale.width),
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: Colors.grey[100]!, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(7)),
                              borderSide: BorderSide(
                                  color: Colors.grey[100]!, width: 1),
                            ),
                            hintText: '호수를 입력해주세요'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: GetBuilder<SignUpController>(
          init: signUpController,
          builder: (controller) {
            return Container(
              height: 150 * Scale.height,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5 * Scale.width,
                  color: controller.selectedRoom.isEmpty
                      ? Colors.grey[400]!
                      : const Color.fromARGB(255, 56, 218, 61),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(14)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15 * Scale.width),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 35 * Scale.width,
                      backgroundColor: Colors.blue[100]!,
                      child: const Icon(Icons.add_box_outlined),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 15 * Scale.width, right: 20 * Scale.width),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "호수 선택",
                            style: textStyle(Colors.black, FontWeight.w700,
                                "NotoSansKR", 19.0),
                          ),
                          Text("STEP 3. 호수를 입력해주세요",
                              style: textStyle(Colors.grey[400]!,
                                  FontWeight.w500, "NotoSansKR", 14.0))
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right_sharp,
                      size: 40,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget questionArea() {
    return Padding(
      padding: EdgeInsets.only(top: 50 * Scale.height),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "나의 매장을 못 찾으시겠나요?",
            style: textStyle(
                Colors.grey[400]!, FontWeight.w500, "NotoSansKR", 14.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                child: Text(
                  "카카오톡 문의하기",
                  style: textStyle(
                      Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
                ),
              ),
              SizedBox(
                height: 13 * Scale.width,
                child: const VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
              ),
              GestureDetector(
                child: Text(
                  "E-mail 문의하기",
                  style: textStyle(
                      Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget bottomSheetArea() {
    return InkWell(
      onTap: () {
        Get.to(SignUpSecond(signUpController: signUpController));
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
