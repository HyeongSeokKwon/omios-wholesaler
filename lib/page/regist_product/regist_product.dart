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

class _RegistProductState extends State<RegistProduct> {
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
            selectCategoryArea(),
            writeProductName(),
            writePriceArea()
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
}
