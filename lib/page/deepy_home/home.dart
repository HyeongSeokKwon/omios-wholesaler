import 'package:deepy_wholesaler/model/product_model.dart';
import 'package:deepy_wholesaler/page/deepy_home/home_controller.dart';
import 'package:deepy_wholesaler/page/regist_product/regist_product.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  HomeController homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scrollArea(),
    );
  }

  Widget scrollArea() {
    return SingleChildScrollView(
      physics: const ScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          wholeSalerInfoArea(),
          wholeSalerProduct(),
        ],
      ),
    );
  }

  Widget wholeSalerInfoArea() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              color: Colors.grey,
              width: 414 * Scale.width,
              height: 250 * Scale.height,
            ),
            Container(
              height: 180 * Scale.height,
            ),
          ],
        ),
        Positioned(
          top: 230 * Scale.height,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                // ignore: prefer_const_literals_to_create_immutables
                border: Border.all(color: Colors.grey[300]!)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15 * Scale.width, vertical: 20 * Scale.height),
              child: Column(
                children: [
                  Text("도매상호 명",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "NotoSansKR", 18.0)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text("등록 상품 수",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0)),
                          Text("N개",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0))
                        ],
                      ),
                      SizedBox(width: 25 * Scale.width),
                      Column(
                        children: [
                          Text("좋아요 수",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0)),
                          Text("N개",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0))
                        ],
                      ),
                      SizedBox(width: 25 * Scale.width),
                      Column(
                        children: [
                          Text("주문 수",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0)),
                          Text("N개",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0))
                        ],
                      ),
                      SizedBox(width: 25 * Scale.width),
                      Column(
                        children: [
                          Text("기타 통계",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0)),
                          Text("N개",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 14.0))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20 * Scale.width,
                  ),
                  Row(
                    children: [
                      TextButton(
                        child: Text("+  상품 등록",
                            style: textStyle(Colors.white, FontWeight.w700,
                                "NotoSansKR", 14.0)),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(110 * Scale.width, 50 * Scale.height)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xffec5363)),
                        ),
                        onPressed: () {
                          Get.to(() => const RegistProduct());
                        },
                      ),
                      SizedBox(
                        width: 10 * Scale.width,
                      ),
                      TextButton(
                        child: Text("상품 관리",
                            style: textStyle(Colors.black, FontWeight.w700,
                                "NotoSansKR", 14.0)),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(110 * Scale.width, 50 * Scale.height)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {},
                      ),
                      SizedBox(
                        width: 10 * Scale.width,
                      ),
                      TextButton(
                        child: Text("배송 관리",
                            style: textStyle(Colors.black, FontWeight.w700,
                                "NotoSansKR", 14.0)),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(110 * Scale.width, 50 * Scale.height)),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget wholeSalerProduct() {
    return FutureBuilder(
      future: homeController.initWholeSalerProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return GetBuilder<HomeController>(
              init: homeController,
              builder: (controller) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: controller.productData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, int index) {
                    return ProductCard(
                        product:
                            Product.fromJson(controller.productData[index]),
                        imageWidth: 110 * Scale.width);
                  },
                );
              },
            );
          } else {
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
                    style: textStyle(
                        Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
                  ),
                  Text(
                    "다시 시도해 주세요",
                    style: textStyle(
                        Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
                  ),
                  SizedBox(height: 15 * Scale.height),
                  GestureDetector(
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
                            style: textStyle(Colors.black, FontWeight.w700,
                                'NotoSansKR', 15.0)),
                      ),
                    ),
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ],
              ),
            );
          }
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
