import 'package:deepy_wholesaler/page/regist_product/regist_controller.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            //selectCategoryArea(),
            SizedBox(height: 8 * Scale.height),
            writeProductName(),
            SizedBox(height: 8 * Scale.height),
            writePriceArea(),
            SizedBox(height: 40 * Scale.height),
            selectColorArea(),
            SizedBox(height: 30 * Scale.height),
            registPhotoArea(),
            SizedBox(height: 30 * Scale.height),
            selectSizeArea(),
            SizedBox(height: 30 * Scale.height),
            registPriceByOptionArea(),
            SizedBox(height: 30 * Scale.height),
            materialArea(),
            SizedBox(height: 30 * Scale.height),
            additionalInfo(),
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
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 14),
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
            style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 15.0),
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
            style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 15.0),
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
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
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
                          color: controller.isColorSelected(colorList[index])
                              ? Colors.indigo[400]!
                              : Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        colorList[index],
                        style: textStyle(
                            controller.isColorSelected(colorList[index])
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
            "사진등록(필수)",
            style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
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
                              registController.getImageFromGallery('basic');
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
                          controller.colorTabController = TabController(
                              initialIndex: controller.colorTabBarViewIndex,
                              length: controller.selectedColor.length,
                              vsync: this);
                          controller.colorTabController.addListener(() {
                            controller.clickColorTabBar(
                                controller.colorTabController.index);
                          });

                          for (var color in controller.selectedColor) {
                            tabList.add(
                              Tab(
                                height: 20 * Scale.height,
                                child: Text(
                                  color['color'],
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "NotoSansKR", 12.0),
                                ),
                              ),
                            );
                            tabBarViewList.add(
                              GetBuilder<RegistController>(
                                  id: 'imageArea',
                                  init: registController,
                                  builder: (controller) {
                                    return Container(
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
                                            registController
                                                .getImageFromGallery('color');
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                            ),
                                            child: controller.selectedColor[
                                                    controller
                                                        .colorTabController
                                                        .index]['image'] ??
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/images/svg/searchImage.svg"),
                                                    Text(
                                                      "  상품사진 선택하기", // 선택한 이미지 들어갈 곳
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
                                    );
                                  }),
                            );
                          }
                          return Column(
                            children: [
                              TabBar(
                                controller: controller.colorTabController,
                                isScrollable: true,
                                physics: const NeverScrollableScrollPhysics(),
                                tabs: tabList,
                              ),
                              SizedBox(
                                height: 300 * Scale.height,
                                child: GetBuilder<RegistController>(
                                    id: 'color',
                                    init: registController,
                                    builder: (controller) {
                                      return Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          controller.selectedColor.isEmpty
                                              ? Center(
                                                  child: Text("색상을 추가해주세요",
                                                      style: textStyle(
                                                          Colors.black,
                                                          FontWeight.w500,
                                                          "NotoSansKR",
                                                          16.0)),
                                                )
                                              : TabBarView(
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  controller: controller
                                                      .colorTabController,
                                                  children: tabBarViewList),
                                          Positioned(
                                            right: 5,
                                            child:
                                                controller.colorTabBarViewIndex ==
                                                            controller
                                                                    .selectedColor
                                                                    .length -
                                                                1 ||
                                                        controller.selectedColor
                                                            .isEmpty
                                                    ? Container()
                                                    : GestureDetector(
                                                        child: const Icon(
                                                            Icons
                                                                .keyboard_arrow_right,
                                                            size: 40),
                                                        onTap: () {
                                                          controller
                                                              .colorTabController
                                                              .index++;
                                                        },
                                                      ),
                                          ),
                                          Positioned(
                                            left: 5,
                                            child: controller
                                                        .colorTabBarViewIndex ==
                                                    0
                                                ? Container()
                                                : GestureDetector(
                                                    child: const Icon(
                                                        Icons
                                                            .keyboard_arrow_left,
                                                        size: 40),
                                                    onTap: () {
                                                      controller
                                                          .colorTabController
                                                          .index--;
                                                    },
                                                  ),
                                          )
                                        ],
                                      );
                                    }),
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
            ),
          ),
        ],
      ),
    );
  }

  Widget selectSizeArea() {
    List<String> sizeList = [
      "S-M",
      "S-L",
      "S-XL",
      "Free",
      "S",
      "M",
      "L",
      "XL",
      "2XL",
      "3XL",
      "55",
      "66",
      "77",
      "88",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "사이즈 선택(필수)",
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
        ),
        SizedBox(height: 10 * Scale.height),
        GetBuilder<RegistController>(
          init: registController,
          builder: (controller) {
            return Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 50 * Scale.height,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.selectedSize.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5 * Scale.width),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Colors.grey[200],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8 * Scale.width),
                              child: Center(
                                child: GestureDetector(
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.selectedSize[index],
                                        style: textStyle(
                                            Colors.black,
                                            FontWeight.w500,
                                            "NotoSansKR",
                                            12.0),
                                      ),
                                      SizedBox(width: 4 * Scale.width),
                                      const Icon(
                                        Icons.clear,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    controller.removeSize(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 17 * Scale.width,
                      vertical: 15 * Scale.height),
                  itemCount: 14,
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
                              color: controller.isSizedSelected(sizeList[index])
                                  ? Colors.indigo[400]!
                                  : Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Text(
                            sizeList[index],
                            style: textStyle(
                                controller.isSizedSelected(sizeList[index])
                                    ? Colors.black
                                    : Colors.grey[400]!,
                                FontWeight.w500,
                                "NotoSansKR",
                                13.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        controller.clickSizeButton(sizeList[index]);
                      },
                    );
                  },
                ),
              ],
            );
          },
        ),
        Table(
          border: TableBorder.all(color: Colors.grey[200]!),
          children: <TableRow>[
            TableRow(children: [
              TableCell(
                child: Container(
                  child: Center(
                    child: Text("사이즈",
                        style: textStyle(
                            Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  child: Center(
                    child: Text("허리둘레",
                        style: textStyle(
                            Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  child: Center(
                    child: Text("힙둘레",
                        style: textStyle(
                            Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  child: Center(
                    child: Text("밑위길이",
                        style: textStyle(
                            Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  child: Center(
                    child: Text("허벅지둘레",
                        style: textStyle(
                            Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  child: Center(
                    child: Text("밑단둘레",
                        style: textStyle(
                            Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                  ),
                ),
              ),
              TableCell(
                child: Container(
                  child: Center(
                    child: Text("총길이",
                        style: textStyle(
                            Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                  ),
                ),
              ),
            ])
          ],
        )
      ],
    );
  }

  Widget registPriceByOptionArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "옵션별 단가 등록하기",
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
        ),
        Divider(
          color: Colors.black,
          thickness: 2 * Scale.height,
        ),
        Row(
          children: [
            Checkbox(value: false, onChanged: (value) {}),
            Text(
              "옵션별로 단가를 등록하려면 체크해주세요.",
              style: textStyle(
                  Colors.grey[600]!, FontWeight.w500, "NotoSansKR", 11.0),
            ),
          ],
        ),
        Divider(
          color: Colors.grey[200],
          thickness: 1 * Scale.height,
        ),
        Text(
          "재고 수량을 적어주시면 더 많은 리스트에 노출 됩니다. (미 작성시 수량은 무제한으로 간주합니다.)",
          style:
              textStyle(Colors.grey[600]!, FontWeight.w500, "NotoSansKR", 11.0),
        ),
        GetBuilder<RegistController>(
          init: registController,
          builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Checkbox(
                        value: controller.pricePerOptionClicked,
                        onChanged: (value) {
                          String missedValue = "";
                          if (controller.selectedColor.isEmpty) {
                            missedValue = missedValue + " [색상]";
                          }
                          if (controller.selectedSize.isEmpty) {
                            missedValue = missedValue + " [사이즈]";
                          }
                          if (controller.priceEditController.text.isEmpty) {
                            missedValue = missedValue + " [가격]";
                          }
                          if (missedValue.isEmpty) {
                            controller.clickPricePerOption();
                          } else {
                            missedValue = missedValue + "의 데이터가 없습니다!";
                            showAlertDialog(context, missedValue);
                          }
                        }),
                    Text(
                      "옵션별로 단가를 등록하려면 체크해주세요.",
                      style: textStyle(Colors.grey[600]!, FontWeight.w500,
                          "NotoSansKR", 11.0),
                    ),
                  ],
                ),
                controller.pricePerOptionClicked == true
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.pricePerOption.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[300]!),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22 * Scale.width,
                                      vertical: 20 * Scale.height),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.pricePerOption[index]
                                            ['color'],
                                        style: textStyle(
                                            Colors.black,
                                            FontWeight.w500,
                                            "NotoSansKR",
                                            14.0),
                                      ),
                                      Text(
                                        controller.pricePerOption[index]
                                            ['size'],
                                        style: textStyle(
                                            Colors.black,
                                            FontWeight.w500,
                                            "NotoSansKR",
                                            14.0),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              controller.changingPricePerOption(
                                                  "minus", index);
                                            },
                                            child: SizedBox(
                                              width: 35 * Scale.width,
                                              height: 35 * Scale.width,
                                              child: SvgPicture.asset(
                                                "assets/images/svg/minus.svg",
                                                width: 18 * Scale.width,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "${int.parse(controller.priceEditController.text) + controller.pricePerOption[index]['price_difference']}",
                                            style: textStyle(
                                                Colors.black,
                                                FontWeight.w500,
                                                "NotoSansKR",
                                                14.0),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              controller.changingPricePerOption(
                                                  "plus", index);
                                            },
                                            child: SizedBox(
                                              width: 35 * Scale.width,
                                              height: 35 * Scale.width,
                                              child: SvgPicture.asset(
                                                "assets/images/svg/plus.svg",
                                                width: 18 * Scale.width,
                                                fit: BoxFit.scaleDown,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5 * Scale.height),
                            ],
                          );
                        },
                      )
                    : const SizedBox(),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget materialArea() {
    List<String> materialList = [
      "면",
      "폴리에스테르",
      "나일론",
      "레이온",
      "울",
      "아크릴",
      "린넨",
      "스판",
      "폴리우레탄",
      "가죽",
      "캐시미어",
      "모달"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "소재",
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
        ),
        Divider(
          color: Colors.black,
          thickness: 2 * Scale.height,
        ),
        Container(
          width: double.maxFinite,
          height: 50 * Scale.height,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Center(
            child: Text(
              " 소재와 혼용률을 직접 입력할 수 있습니다. 띄어쓰기로 구분해 입력됩니다.",
              style: textStyle(
                  Colors.grey[600]!, FontWeight.w500, "NotoSansKR", 11.0),
            ),
          ),
        ),
        GridView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
          itemCount: materialList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (BuildContext context, int index) {
            TextEditingController textEditingController =
                TextEditingController();
            FocusNode myFocusNode = FocusNode();
            myFocusNode.addListener(() {});
            return GetBuilder<RegistController>(
              init: registController,
              builder: (controller) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Transform.scale(
                              scale: 0.8,
                              child: SizedBox(
                                width: 25 * Scale.width,
                                height: 25 * Scale.width,
                                child: Checkbox(
                                  value: controller
                                      .isMaterialSelected(materialList[index]),
                                  onChanged: (value) {
                                    controller.clickMaterialButton(
                                        materialList[index]);
                                  },
                                ),
                              ),
                            ),
                            Text(
                              materialList[index],
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 11.0),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 90 * Scale.width,
                                height: 40 * Scale.height,
                                child: TextFormField(
                                  controller: textEditingController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                  ],
                                  style: const TextStyle(
                                    color: Color(0xff666666),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "NotoSansKR",
                                    fontSize: 13.0,
                                  ),
                                  maxLength: 3,
                                  enabled: controller.isMaterialSelected(
                                          materialList[index])
                                      ? true
                                      : false,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: EdgeInsets.zero,
                                    hintText: "숫자만 입력  %",
                                    hintStyle: textStyle(
                                        const Color(0xffcccccc),
                                        FontWeight.w500,
                                        "NotoSansKR",
                                        11.0),
                                    border: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: Color(0xffcccccc), width: 1),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      borderSide: BorderSide(
                                          color: Color(0xffcccccc), width: 1),
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget addtionalInfoButtonList(String type, List<String> buttonType) {
    return GetBuilder<RegistController>(
      init: registController,
      builder: (controller) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: buttonType.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10 * Scale.width,
                  ),
                  child: Text(
                    buttonType[index],
                    style: textStyle(
                        Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
                  ),
                ),
                SizedBox(
                  width: 15 * Scale.width,
                  child: Radio(
                    value: buttonType[index],
                    activeColor: Colors.grey[500],
                    groupValue: controller.selectedPropertyInfo[type],
                    onChanged: (value) {
                      controller.clickPropertyInfo(type, buttonType[index]);
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget additionalInfo() {
    List<String> thickness = ["두꺼움", "중간", "없음"];
    List<String> seeThrough = ["높음", "중간", "없음"];
    List<String> elasticity = ["높음", "중간", "없음", "벤딩"];
    List<String> lining = ["있음", "없음"];
    List<String> washingInfo = [
      "손세탁",
      "드라이클리닝",
      "물세탁",
      "단독세탁",
      "울세탁",
      "표백제 사용금지",
      "다림질 금지",
      "세탁기 금지"
    ];
    List<String> style = [
      "로맨틱",
      "시크",
      "럭셔리",
      "미시",
      "마담",
      "오피스",
      "캐쥬얼",
      "섹시",
      "모던",
      "유니크",
      "명품 스타일",
      "연예인",
      "심플/베이직"
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "추가정보",
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
        ),
        Divider(
          color: Colors.black,
          thickness: 2 * Scale.height,
        ),
        Column(
          children: [
            SizedBox(
              height: 35 * Scale.height,
              child: Row(
                children: [
                  SizedBox(
                    width: 50 * Scale.width,
                    child: Text(
                      "두께감",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 14.0),
                    ),
                  ),
                  SizedBox(width: 40 * Scale.width),
                  Expanded(
                    child: addtionalInfoButtonList("두께감", thickness),
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 35 * Scale.height,
              child: Row(
                children: [
                  SizedBox(
                    width: 50 * Scale.width,
                    child: Text(
                      "비침",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 14.0),
                    ),
                  ),
                  SizedBox(width: 40 * Scale.width),
                  Expanded(
                    child: addtionalInfoButtonList("비침", seeThrough),
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 35 * Scale.height,
              child: Row(
                children: [
                  SizedBox(
                    width: 50 * Scale.width,
                    child: Text(
                      "신축성",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 14.0),
                    ),
                  ),
                  SizedBox(width: 40 * Scale.width),
                  Expanded(
                    child: addtionalInfoButtonList("신축성", elasticity),
                  ),
                ],
              ),
            ),
            const Divider(),
            SizedBox(
              height: 35 * Scale.height,
              child: Row(
                children: [
                  SizedBox(
                    width: 50 * Scale.width,
                    child: Text(
                      "안감",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 14.0),
                    ),
                  ),
                  SizedBox(width: 40 * Scale.width),
                  Expanded(
                    child: addtionalInfoButtonList("안감", lining),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20 * Scale.height),
        Text(
          "세탁정보 선택",
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 14.0),
        ),
        GetBuilder<RegistController>(
            init: registController,
            builder: (controller) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
                itemCount: washingInfo.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
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
                            color: controller
                                    .isWashingInfoSelected(washingInfo[index])
                                ? Colors.indigo[400]!
                                : Colors.grey[300]!),
                      ),
                      child: Center(
                        child: Text(
                          washingInfo[index],
                          style: textStyle(
                              controller
                                      .isWashingInfoSelected(washingInfo[index])
                                  ? Colors.black
                                  : Colors.grey[400]!,
                              FontWeight.w500,
                              "NotoSansKR",
                              13.0),
                        ),
                      ),
                    ),
                    onTap: () {
                      controller.clickWashingInfo(washingInfo[index]);
                    },
                  );
                },
              );
            }),
        Text(
          "스타일",
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
        ),
        Divider(
          color: Colors.black,
          thickness: 2 * Scale.height,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "스타일을 선택하면 더 많은 리스트에서 노출됩니다.",
            style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 12.0),
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
            itemCount: style.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GetBuilder<RegistController>(
                init: registController,
                builder: (controller) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Transform.scale(
                                scale: 0.8,
                                child: SizedBox(
                                  width: 25 * Scale.width,
                                  height: 25 * Scale.width,
                                  child: Checkbox(
                                    value: controller
                                        .isMaterialSelected(style[index]),
                                    onChanged: (value) {
                                      controller
                                          .clickMaterialButton(style[index]);
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                style[index],
                                style: textStyle(Colors.black, FontWeight.w500,
                                    "NotoSansKR", 11.0),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {},
                  );
                },
              );
            })
      ],
    );
  }
}
