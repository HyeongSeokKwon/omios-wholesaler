import 'package:deepy_wholesaler/page/regist_product/regist_controller.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RegistProduct extends StatefulWidget {
  const RegistProduct({Key? key}) : super(key: key);

  @override
  _RegistProductState createState() => _RegistProductState();
}

class _RegistProductState extends State<RegistProduct>
    with TickerProviderStateMixin {
  RegistController registController = RegistController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        automaticallyImplyLeading: false,
        elevation: 0,
        leadingWidth: 120 * Scale.width,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 15 * Scale.width),
            GestureDetector(
              child: SvgPicture.asset(
                "assets/images/svg/moveToBack.svg",
                height: 17 * Scale.height,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(width: 10 * Scale.width),
            Text("상품 등록",
                style: textStyle(const Color(0xff333333), FontWeight.w700,
                    "NotoSansKR", 20.0)),
          ],
        ),
      ),
      body: scrollArea(),
    );
  }

  Widget scrollArea() {
    return SingleChildScrollView(
        child: Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
        child: Column(
          children: [
            precautionsArea(),
            SizedBox(height: 8 * Scale.height),
            selectCategoryArea(),
            SizedBox(height: 8 * Scale.height),
            writeProductName(),
            SizedBox(height: 8 * Scale.height),
            writePriceArea(),
            SizedBox(height: 40 * Scale.height),
            selectColorArea(),
            SizedBox(height: 30 * Scale.height),
            registPhotoArea(),
          ],
        ),
      ),
    ));
  }

  Widget precautionsArea() {
    return Container(
      width: double.infinity,
      height: 60 * Scale.height,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          "상품등록안내 & 유의사항",
          style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 16.0),
        ),
      ),
    );
  }

  Widget selectCategoryArea() {
    return Column(
      children: [
        Text(
          "카테고리 선택(필수)",
          style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 14),
        ),
      ],
    );
  }

  Widget writeProductName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
          child: Text(
            "상품명 입력(필수)",
            style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
          ),
        ),
        TextField(
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            isDense: true,
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
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: Colors.indigo[400]!, width: 1),
            ),
            hintText: ("상품명을 입력하세요"),
            hintStyle: textStyle(
                const Color(0xffcccccc), FontWeight.w400, "NotoSansKR", 14.0),
          ),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  Widget addPriceButton(String addPrice) {
    return TextButton(
      child: Text("+ $addPrice",
          style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 14.0)),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        fixedSize: MaterialStateProperty.all<Size>(
            Size(70 * Scale.width, 40 * Scale.height)),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () {
        switch (addPrice) {
          case "1천원":
            registController.addPrice(1000);
            break;
          case "3천원":
            registController.addPrice(3000);
            break;
          case "5천원":
            registController.addPrice(5000);
            break;
          case "1만원":
            registController.addPrice(10000);
            break;
          case "2만원":
            registController.addPrice(20000);
            break;
          default:
        }
      },
    );
  }

  Widget writePriceArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
          child: Text(
            "단가(필수)",
            style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
          ),
        ),
        GetBuilder<RegistController>(
            init: registController,
            builder: (controller) {
              return TextField(
                controller: controller.priceEditController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide:
                        BorderSide(color: Colors.indigo[400]!, width: 1),
                  ),
                  hintText: ("상품명을 입력하세요"),
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
                textAlign: TextAlign.left,
              );
            }),
        SizedBox(height: 5 * Scale.height),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            addPriceButton("1천원"),
            SizedBox(
              width: 5 * Scale.width,
            ),
            addPriceButton("3천원"),
            SizedBox(
              width: 5 * Scale.width,
            ),
            addPriceButton("5천원"),
            SizedBox(
              width: 5 * Scale.width,
            ),
            addPriceButton("1만원"),
            SizedBox(
              width: 5 * Scale.width,
            ),
            addPriceButton("2만원"),
          ],
        )
      ],
    );
  }

  Widget selectColorArea() {
    List<String> colorList = [
      "블랙",
      "화이트",
      "브라운",
      "베이지",
      "남색",
      "네이비",
      "옐로우",
      "레드",
      "초록",
      "블루",
      "카키",
      "핑크",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "색상 선택 및 입력(필수)",
          style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
        ),
        GetBuilder<RegistController>(
          init: registController,
          builder: (controller) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: EdgeInsets.symmetric(
                  horizontal: 17 * Scale.width, vertical: 15 * Scale.height),
              itemCount: colorList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 30 * Scale.height,
                crossAxisSpacing: 10 * Scale.width,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                          color: controller.selectedColor
                                  .contains(colorList[index])
                              ? Colors.indigo[400]!
                              : Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        colorList[index],
                        style: textStyle(
                            controller.selectedColor.contains(colorList[index])
                                ? Colors.black
                                : Colors.grey[400]!,
                            FontWeight.w500,
                            "NotoSansKR",
                            13.0),
                      ),
                    ),
                  ),
                  onTap: () {
                    controller.clickColorButton(colorList[index]);
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget registPhotoArea() {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "색상 선택 및 입력(필수)",
            style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
          ),
          TabBar(
            indicatorColor: Colors.indigo[300],
            tabs: [
              Tab(
                  child: Text("기본 이미지",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "NotoSansKR", 12.0))),
              Tab(
                  child: Text("색상별 이미지",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "NotoSansKR", 12.0))),
              Tab(
                  child: Text("디테일 컷",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "NotoSansKR", 12.0)))
            ],
          ),
          Container(
              width: double.infinity,
              height: 500 * Scale.height,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0 * Scale.width),
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                registController.getImageFromGallery();
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        "assets/images/svg/searchImage.svg"),
                                    Text(
                                      "  상품사진 선택하기",
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, "NotoSansKR", 12.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0 * Scale.width),
                        child: GetBuilder<RegistController>(
                          init: registController,
                          builder: (controller) {
                            List<Tab> tabList = [];
                            List<Widget> tabBarViewList = [];
                            TabController colorTabController = TabController(
                                length: controller.selectedColor.length,
                                vsync: this);
                            for (var color in controller.selectedColor) {
                              tabList.add(
                                Tab(
                                  height: 20 * Scale.height,
                                  child: Text(
                                    color,
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 12.0),
                                  ),
                                ),
                              );
                              tabBarViewList.add(
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[50],
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: Center(
                                    child: GestureDetector(
                                      onTap: () {
                                        registController.getImageFromGallery();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SvgPicture.asset(
                                                "assets/images/svg/searchImage.svg"),
                                            Text(
                                              "  상품사진 선택하기",
                                              style: textStyle(
                                                  Colors.black,
                                                  FontWeight.w500,
                                                  "NotoSansKR",
                                                  12.0),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Column(
                              children: [
                                TabBar(
                                  controller: colorTabController,
                                  isScrollable: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  tabs: tabList,
                                ),
                                SizedBox(
                                  height: 300 * Scale.height,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      TabBarView(
                                          controller: colorTabController,
                                          children: tabBarViewList),
                                      colorTabController.index <
                                              controller.selectedColor.length -
                                                  1
                                          ? Positioned(
                                              right: 5,
                                              child: GestureDetector(
                                                child: const Icon(
                                                    Icons.keyboard_arrow_right,
                                                    size: 40),
                                                onTap: () {
                                                  if (colorTabController.index <
                                                      controller.selectedColor
                                                              .length -
                                                          1) {
                                                    colorTabController.index++;
                                                  }
                                                },
                                              ),
                                            )
                                          : Container(),
                                      colorTabController.index >= 0
                                          ? Positioned(
                                              left: 5,
                                              child: GestureDetector(
                                                child: const Icon(
                                                    Icons.keyboard_arrow_left,
                                                    size: 40),
                                                onTap: () {
                                                  if (colorTabController.index >
                                                      0) {
                                                    colorTabController.index--;
                                                  }
                                                },
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                  Container(),
                ],
              )),
        ],
      ),
    );
  }
}
