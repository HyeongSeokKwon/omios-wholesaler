import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/page/login/login.dart';
import 'package:deepy_wholesaler/page/regist_product/regist_product.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';

class WholeSalerInfoArea extends StatelessWidget {
  const WholeSalerInfoArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        if (context.read<MypageBloc>().state.fetchStatus ==
            FetchStatus.fetched) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: (() {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()));
                    }),
                    child: Container(
                      color: Colors.grey,
                      width: 414 * Scale.width,
                      height: 280 * Scale.height,
                    ),
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
                        horizontal: 15 * Scale.width,
                        vertical: 20 * Scale.height),
                    child: Column(
                      children: [
                        Text(
                            context
                                .read<MypageBloc>()
                                .state
                                .userInfoData['name'],
                            style: textStyle(Colors.black, FontWeight.w700,
                                "NotoSansKR", 18.0)),
                        SizedBox(height: 35 * Scale.height),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text("등록 상품 수",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0)),
                                Text("N개",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0))
                              ],
                            ),
                            SizedBox(width: 25 * Scale.width),
                            Column(
                              children: [
                                Text("좋아요 수",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0)),
                                Text("N개",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0))
                              ],
                            ),
                            SizedBox(width: 25 * Scale.width),
                            Column(
                              children: [
                                Text("주문 수",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0)),
                                Text("N개",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0))
                              ],
                            ),
                            SizedBox(width: 25 * Scale.width),
                            Column(
                              children: [
                                Text("기타 통계",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0)),
                                Text("N개",
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "NotoSansKR", 14.0))
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
                                  style: textStyle(Colors.white,
                                      FontWeight.w500, "NotoSansKR", 14.0)),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(110 * Scale.width, 50 * Scale.height)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color(0xffec5363)),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistProduct(
                                              registMode: RegistMode.regist,
                                            )));
                              },
                            ),
                            SizedBox(
                              width: 10 * Scale.width,
                            ),
                            TextButton(
                              child: Text("상품 관리",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "NotoSansKR", 14.0)),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(110 * Scale.width, 50 * Scale.height)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () async {},
                            ),
                            SizedBox(
                              width: 10 * Scale.width,
                            ),
                            TextButton(
                              child: Text("배송 관리",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "NotoSansKR", 14.0)),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    side: BorderSide(color: Colors.grey[300]!),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(110 * Scale.width, 50 * Scale.height)),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
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
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
