import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/alert_dialog.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class RegistProduct extends StatefulWidget {
  const RegistProduct({Key? key}) : super(key: key);

  @override
  _RegistProductState createState() => _RegistProductState();
}

class _RegistProductState extends State<RegistProduct> {
  PriceBloc priceBloc = PriceBloc();
  ColorBloc colorBloc = ColorBloc();
  SizeBloc sizeBloc = SizeBloc();
  FabricBloc fabricBloc = FabricBloc();
  StyleBloc styleBloc = StyleBloc();
  LaundryBloc laundryBloc = LaundryBloc();
  CategoryBloc categoryBloc = CategoryBloc();
  AdditionalInfoBloc additionalInfoBloc = AdditionalInfoBloc();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InititemBloc>(
          create: (BuildContext context) => InititemBloc(
            categoryBloc: categoryBloc,
            colorBloc: colorBloc,
            fabricBloc: fabricBloc,
            styleBloc: styleBloc,
            sizeBloc: sizeBloc,
            laundryBloc: laundryBloc,
            additionalInfoBloc: additionalInfoBloc,
          ),
        ),
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) => categoryBloc,
        ),
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
          create: (BuildContext context) => laundryBloc,
        ),
        BlocProvider<StyleBloc>(
          create: (BuildContext context) => styleBloc,
        ),
        BlocProvider<AdditionalInfoBloc>(
          create: (BuildContext context) => additionalInfoBloc,
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
        body: const ScrollArea(),
      ),
    );
  }
}

class ScrollArea extends StatefulWidget {
  const ScrollArea({Key? key}) : super(key: key);

  @override
  State<ScrollArea> createState() => _ScrollAreaState();
}

class _ScrollAreaState extends State<ScrollArea> with TickerProviderStateMixin {
  TextEditingController priceEditController = TextEditingController();
  late FocusScopeNode currentFocus;
  @override
  Widget build(BuildContext context) {
    return scrollArea();
  }

  Widget scrollArea() {
    currentFocus = FocusScope.of(context);
    return GestureDetector(
      onTap: () {
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.requestFocus(FocusNode());
        }
      },
      child: BlocBuilder<InititemBloc, InititemState>(
        builder: (context, state) {
          if (context.read<InititemBloc>().state.fetchState ==
              FetchState.initial) {
            context.read<InititemBloc>().add(FetchInitCommonInfoEvent());
          }
          if (context.read<InititemBloc>().state.fetchState ==
              FetchState.success) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22 * Scale.width),
                  child: Column(
                    children: [
                      precautionsArea(),
                      SizedBox(height: 8 * Scale.height),
                      selectCategoryArea(), //common
                      SizedBox(height: 8 * Scale.height),
                      writeProductName(), //common
                      SizedBox(height: 8 * Scale.height),
                      writePriceArea(), //common
                      SizedBox(height: 40 * Scale.height),
                      selectColorArea(), //common
                      SizedBox(height: 30 * Scale.height),
                      registPhotoArea(), //common
                      SizedBox(height: 30 * Scale.height),
                      selectSizeArea(), //dynamic
                      SizedBox(height: 30 * Scale.height),
                      registPriceByOptionArea(), //common
                      SizedBox(height: 30 * Scale.height),
                      materialArea(), //common
                      SizedBox(height: 30 * Scale.height),
                      additionalInfo(), //dynamic
                      laundryInfoArea(),
                      styleInfoArea(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return progressBar();
          }
        },
      ),
    );
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
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "카테고리 선택(필수)",
              style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 14),
            ),
            InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
                child: Container(
                  height: 40 * Scale.height,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey[400]!,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(7))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 6 * Scale.width),
                        child: Text(
                            context
                                    .read<CategoryBloc>()
                                    .state
                                    .selectedMainCategory
                                    .isEmpty
                                ? "대분류"
                                : "${state.selectedMainCategory['name']}",
                            style: textStyle(Colors.grey[600]!, FontWeight.w500,
                                'NotoSansKR', 13.0)),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 25,
                        color: Colors.grey[600],
                      )
                    ],
                  ),
                ),
              ),
              onTap: () {
                final categoryBloc = BlocProvider.of<CategoryBloc>(context);
                showModalBottomSheet<void>(
                  isDismissible: false,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  context: context,
                  builder: (context) => BlocProvider.value(
                    value: categoryBloc,
                    child: Stack(
                      children: [
                        BlocBuilder<CategoryBloc, CategoryState>(
                          builder: (context, state) {
                            return GestureDetector(
                              child: Container(
                                  width: 414 * Scale.width,
                                  height: 896 * Scale.height,
                                  color: Colors.transparent),
                              onTap: Navigator.of(context).pop,
                            );
                          },
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 25 * Scale.height,
                                              bottom: 30 * Scale.height),
                                          child: Text("대분류 선택",
                                              style: textStyle(
                                                  const Color(0xff333333),
                                                  FontWeight.w700,
                                                  "NotoSansKR",
                                                  21.0)),
                                        ),
                                        Expanded(
                                          child: Center(
                                            child: ListView.separated(
                                              itemCount:
                                                  state.categoryInfo!.length,
                                              separatorBuilder:
                                                  (context, index) {
                                                return const Divider();
                                              },
                                              itemBuilder: ((context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<CategoryBloc>()
                                                        .add(ClickMainCategoryEvent(
                                                            mainCategoryIndex:
                                                                index));
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
                                                          context
                                                                  .read<
                                                                      CategoryBloc>()
                                                                  .state
                                                                  .categoryInfo![
                                                              index]['name'],
                                                          style: textStyle(
                                                              Colors.black,
                                                              FontWeight.w300,
                                                              "NotoSansKR",
                                                              19.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
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
                  ),
                );
              },
            ),
            InkWell(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5 * Scale.height),
                child: Container(
                    height: 40 * Scale.height,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[400]!,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 6 * Scale.width),
                          child: Text(
                              context
                                      .read<CategoryBloc>()
                                      .state
                                      .selectedSubCategory
                                      .isEmpty
                                  ? "소분류"
                                  : "${state.selectedSubCategory['name']}",
                              style: textStyle(Colors.grey[600]!,
                                  FontWeight.w500, 'NotoSansKR', 13.0)),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 25,
                          color: Colors.grey[600],
                        )
                      ],
                    )),
              ),
              onTap: () {
                final categoryBloc = BlocProvider.of<CategoryBloc>(context);
                if (context
                    .read<CategoryBloc>()
                    .state
                    .selectedMainCategory
                    .isNotEmpty) {
                  showModalBottomSheet<void>(
                    isDismissible: false,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    context: context,
                    builder: (context) => BlocProvider.value(
                      value: categoryBloc,
                      child: Stack(
                        children: [
                          BlocBuilder<CategoryBloc, CategoryState>(
                            builder: (context, state) {
                              return GestureDetector(
                                child: Container(
                                    width: 414 * Scale.width,
                                    height: 896 * Scale.height,
                                    color: Colors.transparent),
                                onTap: Navigator.of(context).pop,
                              );
                            },
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 25 * Scale.height,
                                                bottom: 30 * Scale.height),
                                            child: Text("소분류 선택",
                                                style: textStyle(
                                                    const Color(0xff333333),
                                                    FontWeight.w700,
                                                    "NotoSansKR",
                                                    21.0)),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: ListView.separated(
                                                itemCount: state
                                                    .subCategoryInfo.length,
                                                separatorBuilder:
                                                    (context, index) {
                                                  return const Divider();
                                                },
                                                itemBuilder: ((context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      context
                                                          .read<CategoryBloc>()
                                                          .add(ClickSubCategoryEvent(
                                                              subCategoryIndex:
                                                                  index));
                                                      Navigator.of(context)
                                                          .pop();
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
                                                            context
                                                                    .read<
                                                                        CategoryBloc>()
                                                                    .state
                                                                    .subCategoryInfo[
                                                                index]['name'],
                                                            style: textStyle(
                                                                Colors.black,
                                                                FontWeight.w300,
                                                                "NotoSansKR",
                                                                19.0),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ),
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
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
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
        TextFormField(
          textInputAction: TextInputAction.next,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9' ']")),
          ],
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
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: priceEditController,
                keyboardType: const TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                onChanged: (value) {
                  context
                      .read<PriceBloc>()
                      .add(ChangePriceEvent(changePrice: value));
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (text) {
                  if (text!.trim().isNotEmpty &&
                      int.parse(text.trim()) < 1000) {
                    return '단가의 최솟값은 1000원입니다.';
                  } else {
                    return null;
                  }
                },
                onFieldSubmitted: (value) {
                  currentFocus.unfocus();
                },
                autofocus: false,
                decoration: InputDecoration(
                  isDense: true,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  counterText: "",
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "NotoSansKR",
                    fontStyle: FontStyle.normal,
                    fontSize: 14 * Scale.height,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: const Color(0xffcccccc), width: 1 * Scale.width),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: Colors.indigo[400]!, width: 1 * Scale.width),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: Colors.grey[400]!, width: 1 * Scale.width),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(7)),
                    borderSide: BorderSide(
                        color: Colors.grey[400]!, width: 1 * Scale.width),
                  ),
                  hintText: ("상품명을 입력하세요"),
                  hintStyle: textStyle(const Color(0xffcccccc), FontWeight.w400,
                      "NotoSansKR", 14.0),
                ),
                textAlign: TextAlign.left,
              ),
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
              itemCount: state.colorList.length,
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
                                  .contains(state.colorList[index]['name'])
                              ? Colors.indigo[400]!
                              : Colors.grey[300]!),
                    ),
                    child: Center(
                      child: Text(
                        state.colorList[index]['name'],
                        style: textStyle(
                            context
                                    .read<ColorBloc>()
                                    .state
                                    .selectedColorList
                                    .contains(state.colorList[index]['name'])
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
                        color: state.colorList[index]['name'],
                        colorId: state.colorList[index]['id']));
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
    TabController photoTabController = TabController(length: 2, vsync: this);

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
                buildWhen: ((previous, current) {
                  return previous.basicPhoto != current.basicPhoto;
                }),
                builder: (context, state) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0 * Scale.width),
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
                                      : ReorderableListView.builder(
                                          itemBuilder: (context, index) {
                                            return Container(
                                              color: Colors.indigo[50]!,
                                              key: Key(index.toString()),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5 * Scale.height),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                        width: 50 * Scale.width,
                                                        height:
                                                            50 * Scale.width,
                                                        child: context
                                                            .read<PhotoBloc>()
                                                            .state
                                                            .basicPhoto[index]),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right:
                                                              20 * Scale.width),
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height:
                                                            70 * Scale.height,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text("이미지 $index",
                                                                style: textStyle(
                                                                    Colors.grey[
                                                                        500]!,
                                                                    FontWeight
                                                                        .w500,
                                                                    'NotoSansKR',
                                                                    16 *
                                                                        Scale
                                                                            .width)),
                                                            SizedBox(
                                                                width: 5 *
                                                                    Scale
                                                                        .width),
                                                            Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  GestureDetector(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                          PhotoBloc>()
                                                                      .add(ClickBasicPhotoRemoveEvent(
                                                                          photoIndex:
                                                                              index));
                                                                },
                                                                child: Icon(
                                                                  Icons.clear,
                                                                  size: 20 *
                                                                      Scale
                                                                          .width,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          itemCount: context
                                              .read<PhotoBloc>()
                                              .state
                                              .basicPhoto
                                              .length,
                                          onReorder:
                                              (int oldIndex, int newIndex) {
                                            context.read<PhotoBloc>().add(
                                                ReorderPhotoEvent(
                                                    oldIndex: oldIndex,
                                                    newIndex: newIndex));
                                          })
                                  // : context
                                  //     .read<PhotoBloc>()
                                  //     .state
                                  //     .basicPhoto[0],
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
            ],
          ),
        ),
      ],
    );
  }

  Widget selectSizeArea() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (context.read<CategoryBloc>().state.selectedSubCategory.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "사이즈 선택(필수)",
                style: textStyle(
                    Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
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
                            itemCount: context
                                .read<SizeBloc>()
                                .state
                                .selectedSize
                                .length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.all(5 * Scale.width),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
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
                        itemCount:
                            context.read<SizeBloc>().state.sizeList.length,
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
                                            .contains(state.sizeList[index])
                                        ? Colors.indigo[400]!
                                        : Colors.grey[300]!),
                              ),
                              child: Center(
                                child: Text(
                                  state.sizeList[index]['name'],
                                  style: textStyle(
                                      context
                                              .read<SizeBloc>()
                                              .state
                                              .selectedSize
                                              .contains(
                                                  state.sizeList[index]['name'])
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
                                  .contains(state.sizeList[index]['name'])) {
                                context.read<SizeBloc>().add(
                                    ClickRemoveSizeButton(
                                        size: state.sizeList[index]['name'],
                                        sizeId: state.sizeList[index]['id']));
                              } else {
                                context.read<SizeBloc>().add(ClickSizeButton(
                                    size: state.sizeList[index]['name'],
                                    sizeId: state.sizeList[index]['id']));
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
                            style: textStyle(Colors.black, FontWeight.w500,
                                "NotoSansKR", 10.0)),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text("허리둘레",
                            style: textStyle(Colors.black, FontWeight.w500,
                                "NotoSansKR", 10.0)),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text("힙둘레",
                            style: textStyle(Colors.black, FontWeight.w500,
                                "NotoSansKR", 10.0)),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text("밑위길이",
                            style: textStyle(Colors.black, FontWeight.w500,
                                "NotoSansKR", 10.0)),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text("허벅지둘레",
                            style: textStyle(Colors.black, FontWeight.w500,
                                "NotoSansKR", 10.0)),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text("밑단둘레",
                            style: textStyle(Colors.black, FontWeight.w500,
                                "NotoSansKR", 10.0)),
                      ),
                    ),
                    TableCell(
                      child: Center(
                        child: Text("총길이",
                            style: textStyle(Colors.black, FontWeight.w500,
                                "NotoSansKR", 10.0)),
                      ),
                    ),
                  ])
                ],
              )
            ],
          );
        } else {
          return Container();
        }
      },
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
                                                .fabricList![index]['name'],
                                            fabricIndex: index));
                                  },
                                ),
                              ),
                            ),
                            Text(
                              context
                                  .read<FabricBloc>()
                                  .state
                                  .fabricList![index]['name'],
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
                                child: TextFormField(
                                  controller: state.textController?[index],
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          signed: true),
                                  onChanged: (value) {
                                    context.read<FabricBloc>().add(
                                        InputFabricPercentEvent(
                                            fabricPercent: value,
                                            fabricIndex: index));
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                  ],
                                  onFieldSubmitted: (value) {
                                    currentFocus.unfocus();
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
    List<dynamic>? selectList = [];
    return BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
      builder: (context, state) {
        switch (type) {
          case "thickness":
            selectList = context.read<AdditionalInfoBloc>().state.thicknessList;
            break;
          case "see_through":
            selectList =
                context.read<AdditionalInfoBloc>().state.seeThroughList;
            break;
          case "flexibility":
            selectList =
                context.read<AdditionalInfoBloc>().state.elasticityList;
            break;
          case "lining":
            selectList = context.read<AdditionalInfoBloc>().state.liningList;
            break;
          default:
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: selectList?.length,
          itemBuilder: (context, index) {
            return Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10 * Scale.width,
                  ),
                  child: Text(
                    selectList?[index]['name'],
                    style: textStyle(
                        Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
                  ),
                ),
                SizedBox(
                  width: 15 * Scale.width,
                  child: Radio<dynamic>(
                    value: selectList?[index],
                    activeColor: Colors.grey[500],
                    groupValue: context
                        .read<AdditionalInfoBloc>()
                        .state
                        .selectedAdditionalInfo[type],
                    onChanged: (value) {
                      BlocProvider.of<AdditionalInfoBloc>(context).add(
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
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (context.read<CategoryBloc>().state.selectedSubCategory.isNotEmpty) {
          return BlocBuilder<AdditionalInfoBloc, AdditionalInfoState>(
            builder: (context, state) {
              if (context
                      .read<AdditionalInfoBloc>()
                      .state
                      .elasticityList!
                      .isEmpty &&
                  context
                      .read<AdditionalInfoBloc>()
                      .state
                      .thicknessList!
                      .isEmpty &&
                  context
                      .read<AdditionalInfoBloc>()
                      .state
                      .thicknessList!
                      .isEmpty &&
                  context
                      .read<AdditionalInfoBloc>()
                      .state
                      .liningList!
                      .isEmpty) {
                return Container();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "추가정보",
                    style: textStyle(
                        Colors.black, FontWeight.w700, "NotoSansKR", 18.0),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2 * Scale.height,
                  ),
                  Column(
                    children: [
                      context
                              .read<AdditionalInfoBloc>()
                              .state
                              .thicknessList!
                              .isEmpty
                          ? Container()
                          : SizedBox(
                              height: 35 * Scale.height,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50 * Scale.width,
                                    child: Text(
                                      "두께감",
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, "NotoSansKR", 14.0),
                                    ),
                                  ),
                                  SizedBox(width: 40 * Scale.width),
                                  Expanded(
                                    child: addtionalInfoButtonList("thickness"),
                                  ),
                                ],
                              ),
                            ),
                      const Divider(),
                      context
                              .read<AdditionalInfoBloc>()
                              .state
                              .seeThroughList!
                              .isEmpty
                          ? Container()
                          : SizedBox(
                              height: 35 * Scale.height,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50 * Scale.width,
                                    child: Text(
                                      "비침",
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, "NotoSansKR", 14.0),
                                    ),
                                  ),
                                  SizedBox(width: 40 * Scale.width),
                                  Expanded(
                                    child:
                                        addtionalInfoButtonList("see_through"),
                                  ),
                                ],
                              ),
                            ),
                      const Divider(),
                      context
                              .read<AdditionalInfoBloc>()
                              .state
                              .elasticityList!
                              .isEmpty
                          ? Container()
                          : SizedBox(
                              height: 35 * Scale.height,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50 * Scale.width,
                                    child: Text(
                                      "신축성",
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, "NotoSansKR", 14.0),
                                    ),
                                  ),
                                  SizedBox(width: 40 * Scale.width),
                                  Expanded(
                                    child:
                                        addtionalInfoButtonList("flexibility"),
                                  ),
                                ],
                              ),
                            ),
                      const Divider(),
                      context
                              .read<AdditionalInfoBloc>()
                              .state
                              .liningList!
                              .isEmpty
                          ? Container()
                          : SizedBox(
                              height: 35 * Scale.height,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50 * Scale.width,
                                    child: Text(
                                      "안감",
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, "NotoSansKR", 14.0),
                                    ),
                                  ),
                                  SizedBox(width: 40 * Scale.width),
                                  Expanded(
                                    child: addtionalInfoButtonList("lining"),
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                  SizedBox(height: 20 * Scale.height),
                ],
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget laundryInfoArea() {
    return BlocBuilder<LaundryBloc, LaundryState>(
      builder: (context, state) {
        if (context.read<InititemBloc>().state.fetchState ==
                FetchState.success &&
            context.read<CategoryBloc>().state.selectedSubCategory.isNotEmpty) {
          return BlocBuilder<InititemBloc, InititemState>(
            builder: (context, state) {
              return Column(
                children: [
                  Text(
                    "세탁정보 선택",
                    style: textStyle(
                        Colors.black, FontWeight.w700, "NotoSansKR", 14.0),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
                    itemCount:
                        context.read<LaundryBloc>().state.washingList.length,
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
                              context
                                  .read<LaundryBloc>()
                                  .state
                                  .washingList[index]['name'],
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
                          context.read<LaundryBloc>().add(
                              ClickLaudnryButtonEvent(laundryIndex: index));
                        },
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget styleInfoArea() {
    return BlocBuilder<StyleBloc, StyleState>(builder: ((context, state) {
      return Column(
        children: [
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
              style:
                  textStyle(Colors.black, FontWeight.w500, "NotoSansKR", 12.0),
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
                                                .selectedStyle ==
                                            context
                                                .read<StyleBloc>()
                                                .state
                                                .styleList[index]['name']
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      context.read<StyleBloc>().add(
                                          ClickStyleButtonEvent(
                                              styleIndex: index));
                                    },
                                  ),
                                ),
                              ),
                              Text(
                                context.read<StyleBloc>().state.styleList[index]
                                    ['name'],
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
    }));
  }
}
