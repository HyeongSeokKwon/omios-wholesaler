import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RegistProduct extends StatefulWidget {
  const RegistProduct({Key? key}) : super(key: key);

  @override
  _RegistProductState createState() => _RegistProductState();
}

class _RegistProductState extends State<RegistProduct>
    with TickerProviderStateMixin {
  PriceBloc priceBloc = PriceBloc();
  ColorBloc colorBloc = ColorBloc();
  SizeBloc sizeBloc = SizeBloc();

  FabricBloc fabricBloc = FabricBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PriceBloc>(
          create: (BuildContext context) => priceBloc,
        ),
        BlocProvider<ColorBloc>(
          create: (BuildContext context) => colorBloc,
        ),
        BlocProvider<PhotoBloc>(
          create: (BuildContext context) => PhotoBloc(colorBloc),
        ),
        BlocProvider<SizeBloc>(
          create: (BuildContext context) => sizeBloc,
        ),
        BlocProvider<PricePerOptionBloc>(
          create: (BuildContext context) =>
              PricePerOptionBloc(colorBloc, priceBloc, sizeBloc),
        ),
        BlocProvider<FabricBloc>(
          create: (BuildContext context) => fabricBloc,
        ),
        BlocProvider<LaundryBloc>(
          create: (BuildContext context) => LaundryBloc(),
        ),
        BlocProvider<StyleBloc>(
          create: (BuildContext context) => StyleBloc(),
        ),
        BlocProvider<AdditionalInfoBloc>(
          create: (BuildContext context) => AdditionalInfoBloc(),
        )
      ],
      child: Scaffold(
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
      ),
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

  Widget addPriceButton(
      int addPrice, String unit, TextEditingController priceEditController) {
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return TextButton(
          child: Text("$addPrice" + unit,
              style:
                  textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 14.0)),
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
            switch (unit) {
              case "천원":
                context.read<PriceBloc>().add(ClickAddButtonEvent(
                    addPrice: addPrice * 1000,
                    priceEditController: priceEditController));
                break;
              case "만원":
                context.read<PriceBloc>().add(ClickAddButtonEvent(
                    addPrice: addPrice * 10000,
                    priceEditController: priceEditController));
                break;
            }
          },
        );
      },
    );
  }

  Widget writePriceArea() {
    TextEditingController priceEditController = TextEditingController();
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
              child: Text(
                "단가(필수)",
                style: textStyle(
                    Colors.black, FontWeight.w700, "NotoSansKR", 15.0),
              ),
            ),
            TextField(
              controller: priceEditController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                context
                    .read<PriceBloc>()
                    .add(ChangePriceEvent(changePrice: value));
              },
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
                hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                    "NotoSansKR", 14.0),
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5 * Scale.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addPriceButton(1, "천원", priceEditController),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(3, "천원", priceEditController),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(5, "천원", priceEditController),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(1, "만원", priceEditController),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(2, "만원", priceEditController),
              ],
            )
          ],
        );
      },
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
    return BlocBuilder<ColorBloc, ColorState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "색상 선택 및 입력(필수)",
              style:
                  textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
            ),
            GridView.builder(
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
                          color: context
                                  .read<ColorBloc>()
                                  .state
                                  .selectedColorList
                                  .contains(colorList[index])
                              ? Colors.indigo[400]!
                              : Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        colorList[index],
                        style: textStyle(
                            context
                                    .read<ColorBloc>()
                                    .state
                                    .selectedColorList
                                    .contains(colorList[index])
                                ? Colors.black
                                : Colors.grey[400]!,
                            FontWeight.w500,
                            "NotoSansKR",
                            13.0),
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<ColorBloc>().add(ClickColorButtonEvent(
                        color: colorList[index], colorId: index));
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget registPhotoArea() {
    TabController photoTabController = TabController(length: 3, vsync: this);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "사진등록(필수)",
          style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
        ),
        TabBar(
          controller: photoTabController,
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
            controller: photoTabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              BlocBuilder<PhotoBloc, PhotoState>(
                builder: (context, state) {
                  return Column(
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
                                context
                                    .read<PhotoBloc>()
                                    .add(ClickGetBasicPhotoEvent());
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: context
                                        .read<PhotoBloc>()
                                        .state
                                        .basicPhoto
                                        .isEmpty
                                    ? Row(
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
                                      )
                                    : context
                                        .read<PhotoBloc>()
                                        .state
                                        .basicPhoto[0],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
              BlocBuilder<ColorBloc, ColorState>(
                builder: (context, state) {
                  List<Tab> tabList = [];
                  List<Widget> tabBarViewList = [];
                  TabController colorTabController = TabController(
                      length: (BlocProvider.of<ColorBloc>(context)
                          .state
                          .selectedColorList
                          .length),
                      vsync: this);
                  colorTabController.addListener(() {
                    BlocProvider.of<PhotoBloc>(context).add(ClickMoveButton(
                        colorTabIndex: colorTabController.index));
                  });

                  for (var color in BlocProvider.of<ColorBloc>(context)
                      .state
                      .selectedColorMap) {
                    tabList.add(
                      Tab(
                        height: 20 * Scale.height,
                        child: Text(
                          color['color'],
                          style: textStyle(Colors.black, FontWeight.w500,
                              "NotoSansKR", 12.0),
                        ),
                      ),
                    );
                    tabBarViewList.add(
                      BlocBuilder<PhotoBloc, PhotoState>(
                        builder: (context, state) {
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
                                  context.read<PhotoBloc>().add(
                                      ClickGetColorByPhotoEvent(
                                          color: color['color']));
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                  ),
                                  child: color['images'] ??
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
                        },
                      ),
                    );
                  }
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20.0 * Scale.width),
                        child: Column(
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
                                  BlocProvider.of<ColorBloc>(context)
                                          .state
                                          .selectedColorList
                                          .isEmpty
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
                                          controller: colorTabController,
                                          children: tabBarViewList),
                                  Positioned(
                                      right: 5,
                                      child: BlocBuilder<PhotoBloc, PhotoState>(
                                          builder: ((context, state) {
                                        if (BlocProvider.of<ColorBloc>(context)
                                                        .state
                                                        .selectedColorList
                                                        .length -
                                                    1 ==
                                                BlocProvider.of<PhotoBloc>(
                                                        context)
                                                    .state
                                                    .colorTabIndex ||
                                            BlocProvider.of<ColorBloc>(context)
                                                .state
                                                .selectedColorList
                                                .isEmpty) {
                                          return Container();
                                        } else {
                                          return InkWell(
                                            child: const Icon(
                                                Icons.keyboard_arrow_right, //->
                                                size: 40),
                                            onTap: () {
                                              colorTabController.index++;
                                            },
                                          );
                                        }
                                      }))),
                                  Positioned(
                                    left: 5,
                                    child: BlocBuilder<PhotoBloc, PhotoState>(
                                      builder: ((context, state) {
                                        if (BlocProvider.of<ColorBloc>(context)
                                                .state
                                                .selectedColorList
                                                .isEmpty ||
                                            BlocProvider.of<PhotoBloc>(context)
                                                    .state
                                                    .colorTabIndex ==
                                                0) {
                                          return Container();
                                        } else {
                                          print(context
                                              .read<PhotoBloc>()
                                              .state
                                              .colorTabIndex);
                                          return InkWell(
                                            child: const Icon(
                                                Icons.keyboard_arrow_left, //<-
                                                size: 40),
                                            onTap: () {
                                              colorTabController.index--;
                                            },
                                          );
                                        }
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                },
              ),
              Container(),
            ],
          ),
        ),
      ],
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
        Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 50 * Scale.height,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: BlocBuilder<SizeBloc, SizeState>(
                builder: (context, state) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          context.read<SizeBloc>().state.selectedSize.length,
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
                                child: InkWell(
                                  child: Row(
                                    children: [
                                      Text(
                                        context
                                            .read<SizeBloc>()
                                            .state
                                            .selectedSize[index],
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
                                    context.read<SizeBloc>().add(
                                        ClickRemoveSizeButton(
                                            size: context
                                                .read<SizeBloc>()
                                                .state
                                                .selectedSize[index]));
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
            BlocBuilder<SizeBloc, SizeState>(
              builder: (context, state) {
                return GridView.builder(
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
                              color: context
                                      .read<SizeBloc>()
                                      .state
                                      .selectedSize
                                      .contains(sizeList[index])
                                  ? Colors.indigo[400]!
                                  : Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Text(
                            sizeList[index],
                            style: textStyle(
                                context
                                        .read<SizeBloc>()
                                        .state
                                        .selectedSize
                                        .contains(sizeList[index])
                                    ? Colors.black
                                    : Colors.grey[400]!,
                                FontWeight.w500,
                                "NotoSansKR",
                                13.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        if (context
                            .read<SizeBloc>()
                            .state
                            .selectedSize
                            .contains(sizeList[index])) {
                          context.read<SizeBloc>().add(ClickRemoveSizeButton(
                              size: sizeList[index], sizeId: index));
                        } else {
                          context.read<SizeBloc>().add(ClickSizeButton(
                              size: sizeList[index], sizeId: index));
                        }
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
        Table(
          border: TableBorder.all(color: Colors.grey[200]!),
          children: <TableRow>[
            TableRow(children: [
              TableCell(
                child: Center(
                  child: Text("사이즈",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text("허리둘레",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text("힙둘레",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text("밑위길이",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text("허벅지둘레",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text("밑단둘레",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
                ),
              ),
              TableCell(
                child: Center(
                  child: Text("총길이",
                      style: textStyle(
                          Colors.black, FontWeight.w500, "NotoSansKR", 10.0)),
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
        Text(
          "재고 수량을 적어주시면 더 많은 리스트에 노출 됩니다. (미 작성시 수량은 무제한으로 간주합니다.)",
          style:
              textStyle(Colors.grey[600]!, FontWeight.w500, "NotoSansKR", 11.0),
        ),
        BlocBuilder<PricePerOptionBloc, PricePerOptionState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.indigo[300],
                        side: BorderSide(
                            color: Colors.grey[500]!, width: 1 * Scale.width),
                        value:
                            context.read<PricePerOptionBloc>().state.isClicked,
                        onChanged: (value) {
                          String missedValue = "";
                          if (BlocProvider.of<ColorBloc>(context)
                              .state
                              .selectedColorList
                              .isEmpty) {
                            missedValue = missedValue + " [색상]";
                          }
                          if (BlocProvider.of<SizeBloc>(context)
                              .state
                              .selectedSize
                              .isEmpty) {
                            missedValue = missedValue + " [사이즈]";
                          }
                          if (BlocProvider.of<PriceBloc>(context)
                              .state
                              .price
                              .isEmpty) {
                            missedValue = missedValue + " [가격]";
                          }
                          if (missedValue.isEmpty) {
                            context.read<PricePerOptionBloc>().add(
                                ClickedShowPricePerOptionEvent(
                                    isClicked: value!));
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
                context.read<PricePerOptionBloc>().state.isClicked
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: context
                            .read<PricePerOptionBloc>()
                            .state
                            .pricePerOptionList
                            .length,
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
                                        context
                                            .read<PricePerOptionBloc>()
                                            .state
                                            .pricePerOptionList[index]['color'],
                                        style: textStyle(
                                            Colors.black,
                                            FontWeight.w500,
                                            "NotoSansKR",
                                            14.0),
                                      ),
                                      Text(
                                        context
                                            .read<PricePerOptionBloc>()
                                            .state
                                            .pricePerOptionList[index]['size'],
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
                                              context
                                                  .read<PricePerOptionBloc>()
                                                  .add(
                                                      ClickMinusPriceButtonEvent(
                                                          index: index));
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
                                          BlocBuilder<PricePerOptionBloc,
                                              PricePerOptionState>(
                                            builder: (context, state) {
                                              return Text(
                                                "${int.parse(BlocProvider.of<PriceBloc>(context).state.price) + context.read<PricePerOptionBloc>().state.pricePerOptionList[index]['price_difference']}",
                                                style: textStyle(
                                                    Colors.black,
                                                    FontWeight.w500,
                                                    "NotoSansKR",
                                                    14.0),
                                              );
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              context
                                                  .read<PricePerOptionBloc>()
                                                  .add(
                                                      ClickPlusPriceButtonEvent(
                                                          index: index));
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
        BlocBuilder<FabricBloc, FabricState>(
          builder: (context, state) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
              itemCount: context.read<FabricBloc>().state.fabricList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (BuildContext context, int index) {
                TextEditingController textEditingController =
                    TextEditingController();
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
                                  activeColor: Colors.indigo[300],
                                  side: BorderSide(
                                      color: Colors.grey[500]!,
                                      width: 1 * Scale.width),
                                  value: context
                                      .read<FabricBloc>()
                                      .state
                                      .isClicked[index],
                                  onChanged: (value) {
                                    context.read<FabricBloc>().add(
                                        ClickFabricButtonEvent(
                                            isChecked: value!,
                                            fabric: context
                                                .read<FabricBloc>()
                                                .state
                                                .fabricList![index],
                                            fabricIndex: index));
                                  },
                                ),
                              ),
                            ),
                            Text(
                              context
                                  .read<FabricBloc>()
                                  .state
                                  .fabricList![index],
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 13.0),
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
                                child: TextField(
                                  controller: state.textController?[index],
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    context.read<FabricBloc>().add(
                                        InputFabricPercentEvent(
                                            fabricPercent: value,
                                            fabricIndex: index));
                                  },
                                  style: const TextStyle(
                                    color: Color(0xff666666),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "NotoSansKR",
                                    fontSize: 13.0,
                                  ),
                                  maxLength: 3,
                                  enabled: context
                                          .read<FabricBloc>()
                                          .state
                                          .isClicked[index]
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
                  onTap: () {
                    // context.read<FabricBloc>().add(ClickFabricButtonEvent(isChecked: , fabric: materialList[index], fabricId: index));
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget addtionalInfoButtonList(
    String type,
  ) {
    List<String>? selectList;
    return BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
      builder: (context, state) {
        switch (type) {
          case "두께감":
            selectList = context.read<AdditionalInfoBloc>().state.thicknessList;
            break;
          case "비침":
            selectList =
                context.read<AdditionalInfoBloc>().state.seeThroughList;
            break;
          case "신축성":
            selectList =
                context.read<AdditionalInfoBloc>().state.elasticityList;
            break;
          case "안감":
            selectList = context.read<AdditionalInfoBloc>().state.liningList;
            break;
          default:
        }
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: selectList!.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10 * Scale.width,
                  ),
                  child: Text(
                    selectList![index],
                    style: textStyle(
                        Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
                  ),
                ),
                SizedBox(
                  width: 15 * Scale.width,
                  child: Radio(
                    value: selectList![index],
                    activeColor: Colors.grey[500],
                    groupValue: context
                        .read<AdditionalInfoBloc>()
                        .state
                        .selectedAdditionalInfo[type],
                    onChanged: (value) {
                      context.read<AdditionalInfoBloc>().add(
                          ClickAdditionalInfoEvent(index: index, type: type));
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
                    child: addtionalInfoButtonList("두께감"),
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
                    child: addtionalInfoButtonList("비침"),
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
                    child: addtionalInfoButtonList("신축성"),
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
                    child: addtionalInfoButtonList("안감"),
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
        BlocBuilder<LaundryBloc, LaundryState>(
          builder: (context, state) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
              itemCount: context.read<LaundryBloc>().state.washingList.length,
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
                          color: context
                                  .read<LaundryBloc>()
                                  .state
                                  .selectedLaundry
                                  .contains(context
                                      .read<LaundryBloc>()
                                      .state
                                      .washingList[index])
                              ? Colors.indigo[400]!
                              : Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        context.read<LaundryBloc>().state.washingList[index],
                        style: textStyle(
                            context
                                    .read<LaundryBloc>()
                                    .state
                                    .selectedLaundry
                                    .contains(context
                                        .read<LaundryBloc>()
                                        .state
                                        .washingList[index])
                                ? Colors.black
                                : Colors.grey[400]!,
                            FontWeight.w500,
                            "NotoSansKR",
                            13.0),
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<LaundryBloc>().add(ClickLaudnryButtonEvent(
                        laundryType: context
                            .read<LaundryBloc>()
                            .state
                            .washingList[index]));
                  },
                );
              },
            );
          },
        ),
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
            style: textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
          ),
        ),
        BlocBuilder<StyleBloc, StyleState>(
          builder: (context, state) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
              itemCount: context.read<StyleBloc>().state.styleList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (BuildContext context, int index) {
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
                                  activeColor: Colors.indigo[300],
                                  side: BorderSide(
                                      color: Colors.grey[500]!,
                                      width: 1 * Scale.width),
                                  value: context
                                      .read<StyleBloc>()
                                      .state
                                      .isClicked[index],
                                  onChanged: (value) {
                                    context.read<StyleBloc>().add(
                                        ClickStyleButtonEvent(
                                            styleIndex: index));
                                  },
                                ),
                              ),
                            ),
                            Text(
                              context.read<StyleBloc>().state.styleList[index],
                              style: textStyle(Colors.black, FontWeight.w500,
                                  "NotoSansKR", 13.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    context
                        .read<StyleBloc>()
                        .add(ClickStyleButtonEvent(styleIndex: index));
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
