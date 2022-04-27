import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:deepy_wholesaler/page/regist_product/regist_product.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../bloc/bloc.dart';

class EditProduct extends StatefulWidget {
  final int productId;
  const EditProduct({required this.productId, Key? key}) : super(key: key);

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InitEditItemBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
          ),
        ),
        backgroundColor: Colors.white,
        body: ScrollArea(productId: widget.productId),
        extendBodyBehindAppBar: true,
      ),
    );
  }
}

class ScrollArea extends StatefulWidget {
  final int productId;
  const ScrollArea({required this.productId, Key? key}) : super(key: key);

  @override
  State<ScrollArea> createState() => _ScrollAreaState();
}

class _ScrollAreaState extends State<ScrollArea> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitEditItemBloc, InitEditItemState>(
      builder: (context, state) {
        if (state.fetchState == FetchState.initial) {
          context
              .read<InitEditItemBloc>()
              .add(LoadEditProductDataEvent(productId: widget.productId));
          return progressBar();
        } else if (state.fetchState == FetchState.success) {
          return SingleChildScrollView(
            child: Column(children: [
              ImageArea(),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 22 * Scale.width, vertical: 22 * Scale.height),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InfoArea(),
                    SizedBox(height: 30 * Scale.height),
                    const EditButtonArea(),
                    SizedBox(height: 20 * Scale.height),
                    const ProductInfo()
                  ],
                ),
              ),
            ]),
          );
        } else if (state.fetchState == FetchState.error) {
          return networkErrorArea();
        } else {
          return progressBar();
        }
      },
    );
  }

  Widget networkErrorArea() {
    return BlocBuilder<InitEditItemBloc, InitEditItemState>(
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
                  setState(() {
                    context.read<InitEditItemBloc>().add(
                        LoadEditProductDataEvent(productId: widget.productId));
                  });
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
                        style: textStyle(
                            Colors.black, FontWeight.w700, 'NotoSansKR', 15.0)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ImageArea extends StatelessWidget {
  final PageController _pageController = PageController();
  final List imageUrls = [];

  ImageArea({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    for (var value in context.read<InitEditItemBloc>().state.data['images']) {
      imageUrls.add(value['image_url']);
    }
    for (var value in context.read<InitEditItemBloc>().state.data['colors']) {
      imageUrls.add(value['image_url']);
    }
    return SizedBox(
      width: 414 * Scale.width,
      height: 1.2 * 414 * Scale.width,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: imageUrls.length,
            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                child: GestureDetector(
                  child: CachedNetworkImage(
                    imageUrl: "${imageUrls[index]}",
                    fit: BoxFit.fill,
                    width: 414 * Scale.width,
                    height: 1.2 * 414 * Scale.width,
                  ),
                  onTap: () {},
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: imageUrls.length,
                effect: const WormEffect(
                    spacing: 8.0,
                    dotWidth: 15.0,
                    dotHeight: 15.0,
                    strokeWidth: 1.5,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoArea extends StatelessWidget {
  const InfoArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InitEditItemBloc, InitEditItemState>(
      builder: (context, state) {
        return SizedBox(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${state.data['name']}(${state.data['id']})",
              style:
                  textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 20.0),
            ),
            Text(
              setNumberFormat(state.data['price']) + '원',
              style:
                  textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 20.0),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '구매 수  ${setNumberFormat(13448)}',
                  style: textStyle(
                      Colors.black, FontWeight.w400, "NotoSansKR", 14.0),
                ),
                Text(
                  '찜 수  ${setNumberFormat(113472)}',
                  style: textStyle(
                      Colors.black, FontWeight.w400, "NotoSansKR", 14.0),
                )
              ],
            )
          ],
        ));
      },
    );
  }
}

class EditButtonArea extends StatelessWidget {
  const EditButtonArea({Key? key}) : super(key: key);
  static const edit = "수정";
  static const delete = "삭제";
  static const soldOut = "품절";
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              child: Text(edit,
                  style: textStyle(
                      Colors.grey[700]!, FontWeight.w400, "NotoSansKR", 15.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(110 * Scale.width, 60 * Scale.height)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                final initEditItemBloc =
                    BlocProvider.of<InitEditItemBloc>(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistProduct(
                        registMode: RegistMode.edit,
                        initEditItemBloc: initEditItemBloc),
                  ),
                );
              },
            ),
            SizedBox(
              width: 12 * Scale.width,
            ),
            TextButton(
              child: Text(soldOut,
                  style: textStyle(
                      Colors.grey[700]!, FontWeight.w400, "NotoSansKR", 15.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(110 * Scale.width, 60 * Scale.height)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                if (Platform.isIOS) {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          content: const Text("상품을 품절하시겠습니까?"),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("확인"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("취소"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          "상품을 품절하시겠습니까?",
                          style: textStyle(Colors.black, FontWeight.w500,
                              'NotoSansKR', 16.0),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              "확인",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  'NotoSansKR', 15.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              "취소",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  'NotoSansKR', 15.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            SizedBox(
              width: 12 * Scale.width,
            ),
            TextButton(
              child: Text(delete,
                  style: textStyle(
                      Colors.grey[700]!, FontWeight.w400, "NotoSansKR", 15.0)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                fixedSize: MaterialStateProperty.all<Size>(
                    Size(110 * Scale.width, 60 * Scale.height)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                if (Platform.isIOS) {
                  return showDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          content: const Text("상품을 삭제하시겠습니까?"),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("확인"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            CupertinoDialogAction(
                              isDefaultAction: true,
                              child: const Text("취소"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text(
                          "상품을 삭제하시겠습니까?",
                          style: textStyle(Colors.black, FontWeight.w500,
                              'NotoSansKR', 16.0),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              "확인",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  'NotoSansKR', 15.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              "취소",
                              style: textStyle(Colors.black, FontWeight.w500,
                                  'NotoSansKR', 15.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
        SizedBox(
          height: 15 * Scale.height,
        ),
        TextButton(
          child: Text("당일발송가능 재고",
              style: textStyle(
                  Colors.grey[700]!, FontWeight.w400, "NotoSansKR", 15.0)),
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            fixedSize: MaterialStateProperty.all<Size>(
                Size(354 * Scale.width, 60 * Scale.height)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () async {},
        ),
      ],
    ));
  }
}

class ProductInfo extends StatelessWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map productData =
        BlocProvider.of<InitEditItemBloc>(context).state.data;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        productInfoValueWidget("카테고리",
            "${productData['main_category']['name']} > ${productData['sub_category']['name']}"),
        productInfoValueWidget(
            "색상", context.read<InitEditItemBloc>().state.color.join(' ,')),
        productInfoValueWidget(
            '사이즈', context.read<InitEditItemBloc>().state.size.join(' ,')),
        productInfoValueWidget("실측지수", '확인하기'),
        productInfoValueWidget("재고수량", '확인하기'),
        productInfoValueWidget(
            "소재",
            List.generate(
                    productData['materials'].length,
                    (index) =>
                        '${productData['materials'][index]['material']} ${productData['materials'][index]['mixing_rate']}%')
                .join(' ,')),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6 * Scale.height),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "추가정보",
                  style: textStyle(
                      Colors.black, FontWeight.w400, 'NotoSansKR', 15.0),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3 * Scale.height),
                      child: Text(
                        '두께감 : ${productData['thickness']['name']}',
                        style: textStyle(Colors.grey[700]!, FontWeight.w400,
                            'NotoSansKR', 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3 * Scale.height),
                      child: Text(
                        '비침 : ${productData['see_through']['name']}',
                        style: textStyle(Colors.grey[700]!, FontWeight.w400,
                            'NotoSansKR', 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3 * Scale.height),
                      child: Text(
                        '신축성 : ${productData['flexibility']['name']}',
                        style: textStyle(Colors.grey[700]!, FontWeight.w400,
                            'NotoSansKR', 15.0),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3 * Scale.height),
                      child: Text(
                        '안감 : ${productData['lining'] ? '있음' : '없음'}',
                        style: textStyle(Colors.grey[700]!, FontWeight.w400,
                            'NotoSansKR', 15.0),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
        productInfoValueWidget(
            "세탁정보",
            List.generate(
                productData['laundry_informations'].length,
                (index) => productData['laundry_informations'][index]
                    ['name']).join(' ,')),
        productInfoValueWidget("스타일", productData['style']['name']),
        productInfoValueWidget("제조국", productData['manufacturing_country']),
        productInfoValueWidget("타겟 연령층", productData['age']['name']),
        productInfoValueWidget(
            "태그",
            List.generate(productData['tags'].length,
                (index) => productData['tags'][index]['name']).join(' ,')),
        productInfoValueWidget("테마", productData['theme']['name']),
      ],
    );
  }

  Widget productInfoValueWidget(String subject, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7 * Scale.height),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            subject,
            style: textStyle(Colors.black, FontWeight.w400, 'NotoSansKR', 15.0),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(left: 60 * Scale.width),
              child: Text(
                value,
                style: textStyle(
                    Colors.grey[700]!, FontWeight.w400, 'NotoSansKR', 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
