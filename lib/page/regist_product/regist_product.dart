import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/bloc/network_connection_bloc/network_connection_bloc.dart';
import 'package:deepy_wholesaler/bloc/regist_product_bloc/data_gather_bloc/data_gather_bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/home.dart';
import 'package:deepy_wholesaler/util/util.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reorderables/reorderables.dart';

class RegistProduct extends StatefulWidget {
  final RegistMode registMode;
  final InitEditItemBloc? initEditItemBloc;
  const RegistProduct(
      {Key? key, required this.registMode, this.initEditItemBloc})
      : super(key: key);

  @override
  _RegistProductState createState() => _RegistProductState();
}

class _RegistProductState extends State<RegistProduct> {
  @override
  Widget build(BuildContext context) {
    NameBloc nameBloc = NameBloc();
    PriceBloc priceBloc = PriceBloc();
    ColorBloc colorBloc = ColorBloc();
    SizeBloc sizeBloc = SizeBloc();
    PricePerOptionBloc pricePerOptionBloc =
        PricePerOptionBloc(colorBloc, priceBloc, sizeBloc);
    FabricBloc fabricBloc = FabricBloc();
    StyleBloc styleBloc = StyleBloc();
    LaundryBloc laundryBloc = LaundryBloc();
    CategoryBloc categoryBloc = CategoryBloc();
    AdditionalInfoBloc additionalInfoBloc = AdditionalInfoBloc();
    ManufacturecountryBloc manufacturecountryBloc = ManufacturecountryBloc();
    AgeGroupBloc ageGroupBloc = AgeGroupBloc();
    PhotoBloc photoBloc = PhotoBloc(colorBloc);
    ThemeBloc themeBloc = ThemeBloc();
    TagBloc tagBloc = TagBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => NetworkConnectionBloc()),
        BlocProvider<InititemBloc>(
          create: (BuildContext context) => InititemBloc(
            nameBloc: nameBloc,
            priceBloc: priceBloc,
            categoryBloc: categoryBloc,
            colorBloc: colorBloc,
            fabricBloc: fabricBloc,
            photoBloc: photoBloc,
            styleBloc: styleBloc,
            sizeBloc: sizeBloc,
            pricePerOptionBloc: pricePerOptionBloc,
            laundryBloc: laundryBloc,
            additionalInfoBloc: additionalInfoBloc,
            tagBloc: tagBloc,
            ageGroupBloc: ageGroupBloc,
            themeBloc: themeBloc,
            registMode: widget.registMode,
            manufacturecountryBloc: manufacturecountryBloc,
            initEditItemBloc: widget.initEditItemBloc,
          ),
        ),
        BlocProvider<NameBloc>(
          create: (BuildContext context) => nameBloc,
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
          create: (BuildContext context) => photoBloc,
        ),
        BlocProvider<SizeBloc>(
          create: (BuildContext context) => sizeBloc,
        ),
        BlocProvider<PricePerOptionBloc>(
          create: (BuildContext context) => pricePerOptionBloc,
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
        ),
        BlocProvider<ManufacturecountryBloc>(
          create: (BuildContext context) => manufacturecountryBloc,
        ),
        BlocProvider<AgeGroupBloc>(
          create: (BuildContext context) => ageGroupBloc,
        ),
        BlocProvider<TagBloc>(create: (BuildContext context) => tagBloc),
        BlocProvider<ThemeBloc>(create: (BuildContext context) => themeBloc),
        BlocProvider<DataGatherBloc>(
            create: (BuildContext context) => DataGatherBloc(
                  nameBloc: nameBloc,
                  categoryBloc: categoryBloc,
                  priceBloc: priceBloc,
                  colorBloc: colorBloc,
                  photoBloc: photoBloc,
                  pricePerOptionBloc: pricePerOptionBloc,
                  styleBloc: styleBloc,
                  fabricBloc: fabricBloc,
                  sizeBloc: sizeBloc,
                  laundryBloc: laundryBloc,
                  additionalInfoBloc: additionalInfoBloc,
                  ageGroupBloc: ageGroupBloc,
                  tagBloc: tagBloc,
                  themeBloc: themeBloc,
                  manufacturecountryBloc: manufacturecountryBloc,
                  initEditItemBloc: widget.initEditItemBloc,
                ))
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
                      "Pretendard", 20.0)),
            ],
          ),
        ),
        body: BlocBuilder<NetworkConnectionBloc, NetworkConnectionState>(
          builder: (context, state) {
            if (context.read<NetworkConnectionBloc>().state.networkState ==
                NetworkState.active) {
              return ScrollArea(registMode: widget.registMode);
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "네트워크에 연결하지 못했어요",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "Pretendard", 20.0),
                    ),
                    Text(
                      "네트워크 연결상태를 확인하고",
                      style: textStyle(
                          Colors.grey, FontWeight.w500, "Pretendard", 13.0),
                    ),
                    Text(
                      "다시 시도해 주세요",
                      style: textStyle(
                          Colors.grey, FontWeight.w500, "Pretendard", 13.0),
                    ),
                    SizedBox(height: 15 * Scale.height),
                    InkWell(
                      onTap: () {
                        setState(() {
                          context
                              .read<InititemBloc>()
                              .add(const FetchInitCommonInfoEvent());
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
                              style: textStyle(Colors.black, FontWeight.w700,
                                  'Pretendard', 15.0)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class ScrollArea extends StatefulWidget {
  final RegistMode registMode;
  const ScrollArea({required this.registMode, Key? key}) : super(key: key);

  @override
  State<ScrollArea> createState() => _ScrollAreaState();
}

class _ScrollAreaState extends State<ScrollArea> with TickerProviderStateMixin {
  late FocusScopeNode currentFocus;

  @override
  void initState() {
    super.initState();
  }

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
            context.read<InititemBloc>().add(const FetchInitCommonInfoEvent());
          }

          if (context.read<InititemBloc>().state.fetchState ==
              FetchState.success) {
            if (widget.registMode == RegistMode.edit &&
                BlocProvider.of<DataGatherBloc>(context).state.fetchState ==
                    FetchState.initial &&
                BlocProvider.of<CategoryBloc>(context)
                    .state
                    .selectedSubCategory
                    .isNotEmpty &&
                BlocProvider.of<DataGatherBloc>(context).state.gatherState ==
                    GatherState.initial) {
              BlocProvider.of<DataGatherBloc>(context).add(CombineDataEvent(
                  registMode: widget.registMode, callState: 'init'));
            }
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22 * Scale.width),
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
                          SizedBox(height: 40 * Scale.height),
                          registPhotoArea(), //common
                          SizedBox(height: 40 * Scale.height),
                          selectSizeArea(), //dynamic
                          SizedBox(height: 40 * Scale.height),
                          registPriceByOptionArea(), //common
                          SizedBox(height: 40 * Scale.height),
                          materialArea(), //common
                          SizedBox(height: 40 * Scale.height),
                          additionalInfo(), //dynamic
                          SizedBox(height: 40 * Scale.height),
                          laundryInfoArea(),
                          SizedBox(height: 40 * Scale.height),
                          styleInfoArea(),
                          SizedBox(height: 40 * Scale.height),
                          manufactureCountryArea(),
                          SizedBox(height: 40 * Scale.height),
                          ageGroupArea(),

                          SizedBox(height: 40 * Scale.height),
                          searchTagArea(),
                          themeArea(), SizedBox(height: 100 * Scale.height),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(bottom: 0, child: registryButton()),
              ],
            );
          } else if (context.read<InititemBloc>().state.fetchState ==
              FetchState.error) {
            return networkErrorArea();
          } else {
            return progressBar();
          }
        },
      ),
    );
  }

  Widget networkErrorArea() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "네트워크에 연결하지 못했어요",
            style: textStyle(Colors.black, FontWeight.w700, "Pretendard", 20.0),
          ),
          Text(
            "네트워크 연결상태를 확인하고",
            style: textStyle(Colors.grey, FontWeight.w500, "Pretendard", 13.0),
          ),
          Text(
            "다시 시도해 주세요",
            style: textStyle(Colors.grey, FontWeight.w500, "Pretendard", 13.0),
          ),
          SizedBox(height: 15 * Scale.height),
          InkWell(
            onTap: () {
              setState(() {
                context
                    .read<InititemBloc>()
                    .add(const FetchInitCommonInfoEvent());
              });
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      const BorderRadiusDirectional.all(Radius.circular(19))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 17 * Scale.width, vertical: 14 * Scale.height),
                child: Text("다시 시도하기",
                    style: textStyle(
                        Colors.black, FontWeight.w700, 'Pretendard', 15.0)),
              ),
            ),
          ),
        ],
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
          style: textStyle(Colors.black, FontWeight.w500, "Pretendard", 16.0),
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
              style: textStyle(Colors.black, FontWeight.w600, "Pretendard", 15),
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
                                'Pretendard', 13.0)),
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
                if (widget.registMode == RegistMode.regist) {
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
                                                    "Pretendard",
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
                                                                    .categoryInfo![
                                                                index]['name'],
                                                            style: textStyle(
                                                                Colors.black,
                                                                FontWeight.w300,
                                                                "Pretendard",
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
                                  FontWeight.w500, 'Pretendard', 13.0)),
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
                if (widget.registMode == RegistMode.regist) {
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
                                                      "Pretendard",
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
                                                  itemBuilder:
                                                      ((context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        context
                                                            .read<
                                                                CategoryBloc>()
                                                            .add(ClickSubCategoryEvent(
                                                                subCategoryIndex:
                                                                    index));

                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: SizedBox(
                                                        height:
                                                            70 * Scale.height,
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
                                                                  FontWeight
                                                                      .w300,
                                                                  "Pretendard",
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
            style: textStyle(Colors.black, FontWeight.w600, "Pretendard", 15.0),
          ),
        ),
        BlocBuilder<NameBloc, NameState>(
          builder: (context, state) {
            return Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                textInputAction: TextInputAction.next,
                validator: (text) {
                  if (text!.trim().isEmpty) {
                    return '상품명을 입력해주세요.';
                  } else {
                    return null;
                  }
                },
                controller: state.textEditingController,
                onChanged: (value) {
                  context.read<NameBloc>().add(ChangeNameEvent(name: value));
                },
                decoration: InputDecoration(
                  isDense: true,
                  counterText: "",
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelStyle: TextStyle(
                    color: const Color(0xff666666),
                    height: 0.6,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Pretendard",
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
                      "Pretendard", 14.0),
                ),
                textAlign: TextAlign.left,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget addPriceButton(int addPrice, String unit) {
    return BlocBuilder<PriceBloc, PriceState>(
      builder: (context, state) {
        return TextButton(
          child: Text("$addPrice" + unit,
              style:
                  textStyle(Colors.black, FontWeight.w500, "Pretendard", 14.0)),
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
                    priceEditController: state.textEditingController));
                break;
              case "만원":
                context.read<PriceBloc>().add(ClickAddButtonEvent(
                    addPrice: addPrice * 10000,
                    priceEditController: state.textEditingController));
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
                    Colors.black, FontWeight.w600, "Pretendard", 15.0),
              ),
            ),
            Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: state.textEditingController,
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
                  } else if (text.trim().isNotEmpty &&
                      int.parse(text.trim()) % 100 < 100 &&
                      int.parse(text.trim()) % 100 > 0) {
                    return '단가의 최소단위는 100원입니다.';
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
                    fontFamily: "Pretendard",
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
                      "Pretendard", 14.0),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 5 * Scale.height),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                addPriceButton(1, "천원"),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(3, "천원"),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(5, "천원"),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(1, "만원"),
                SizedBox(
                  width: 5 * Scale.width,
                ),
                addPriceButton(2, "만원"),
              ],
            ),
            SizedBox(height: 5 * Scale.height),
            state.retailPrice != '0'
                ? Text("예상 판매가격 ${state.retailPrice}")
                : const SizedBox(),
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
                  textStyle(Colors.black, FontWeight.w600, "Pretendard", 17.0),
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
                            FontWeight.w600,
                            "Pretendard",
                            13.0),
                      ),
                    ),
                  ),
                  onTap: () {
                    context.read<ColorBloc>().add(
                          ClickColorAddButtonEvent(
                              color: state.colorList[index]['name'],
                              customedName: state.colorList[index]['name'],
                              colorId: state.colorList[index]['id']),
                        );
                  },
                );
              },
            ),
            context.read<ColorBloc>().state.errorMessage.isEmpty
                ? Container()
                : Text(context.read<ColorBloc>().state.errorMessage),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    context.read<ColorBloc>().state.selectedColorMap.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4 * Scale.height),
                    child: Container(
                      color: Colors.grey[50]!,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10 * Scale.height),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10 * Scale.width),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.read<ColorBloc>().add(
                                          ClickColorRemoveButtonEvent(
                                              customedName: context
                                                      .read<ColorBloc>()
                                                      .state
                                                      .selectedColorMap[index]
                                                  ['customedName'],
                                              color: context
                                                      .read<ColorBloc>()
                                                      .state
                                                      .selectedColorMap[index]
                                                  ['color'],
                                              colorId: context
                                                      .read<ColorBloc>()
                                                      .state
                                                      .selectedColorMap[index]
                                                  ['colorId']));
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 20 * Scale.width,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  SizedBox(width: 5 * Scale.width),
                                  Text(
                                    "계열 : ${context.read<ColorBloc>().state.selectedColorMap[index]['color']}",
                                    style: textStyle(Colors.grey[700]!,
                                        FontWeight.w400, "Pretendard", 16.0),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "색상이름 : ",
                                    style: textStyle(Colors.grey[700]!,
                                        FontWeight.w400, "Pretendard", 16.0),
                                  ),
                                  SizedBox(
                                    width: 100 * Scale.width,
                                    height: 30 * Scale.width,
                                    child: TextFormField(
                                      key: Key(state.selectedColorMap[index]
                                              ['colorId']
                                          .toString()),
                                      style: textStyle(Colors.grey[700]!,
                                          FontWeight.w400, "Pretendard", 15.0),
                                      initialValue: context
                                              .read<ColorBloc>()
                                              .state
                                              .selectedColorMap[index]
                                          ['customedName'],
                                      onChanged: ((value) {
                                        context.read<ColorBloc>().add(
                                            ChangeColorCustomedNameEvent(
                                                customedName: value,
                                                selectedColorIndex: index));
                                      }),
                                      maxLength: 15,
                                      showCursor: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding: EdgeInsets.fromLTRB(
                                          6 * Scale.width,
                                          6 * Scale.height,
                                          6 * Scale.width,
                                          6 * Scale.height,
                                        ),
                                        counterText: "",
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.auto,
                                        labelStyle: TextStyle(
                                          color: const Color(0xff666666),
                                          height: 0.6,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Pretendard",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 150 * Scale.height,
                                        ),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                          borderSide: BorderSide(
                                              color: Color(0xffcccccc),
                                              width: 1),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                          borderSide: BorderSide(
                                              color: Color(0xffcccccc),
                                              width: 1),
                                        ),
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                })
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
          style: textStyle(Colors.black, FontWeight.w600, "Pretendard", 17.0),
        ),
        TabBar(
          controller: photoTabController,
          indicatorColor: Colors.indigo[300],
          tabs: [
            Tab(
                child: Text("기본 이미지",
                    style: textStyle(
                        Colors.black, FontWeight.w500, "Pretendard", 13.0))),
            Tab(
                child: Text("색상별 이미지",
                    style: textStyle(
                        Colors.black, FontWeight.w500, "Pretendard", 13.0))),
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
                                                  "Pretendard",
                                                  12.0),
                                            ),
                                          ],
                                        )
                                      : ReorderableWrap(
                                          spacing: 8.0,
                                          runSpacing: 4.0,
                                          padding: const EdgeInsets.all(8),
                                          children: List.generate(
                                            state.basicPhoto.length,
                                            (index) => Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(9)),
                                                  child: state.basicPhoto[index]
                                                      ['image'],
                                                ),
                                                Positioned(
                                                  right: -10 * Scale.width,
                                                  top: -10 * Scale.width,
                                                  child: IconButton(
                                                    iconSize: 20 * Scale.width,
                                                    icon: const Icon(
                                                        Icons.remove_circle),
                                                    color: Colors.red,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            0.0),
                                                    onPressed: () {
                                                      context.read<PhotoBloc>().add(
                                                          ClickBasicPhotoRemoveEvent(
                                                              photoIndex:
                                                                  index));
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          onReorder:
                                              (int oldIndex, int newIndex) {
                                            context.read<PhotoBloc>().add(
                                                ReorderPhotoEvent(
                                                    oldIndex: oldIndex,
                                                    newIndex: newIndex));
                                          },
                                          onNoReorder: (int index) {
                                            //this callback is optional
                                            debugPrint(
                                                '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
                                          },
                                          onReorderStarted: (int index) {
                                            //this callback is optional
                                            debugPrint(
                                                '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
                                          })
                                  // ReorderableListView.builder(
                                  //     physics:
                                  //         NeverScrollableScrollPhysics(),
                                  //     itemBuilder: (context, index) {
                                  //       return Container(
                                  //         color: Colors.indigo[50]!,
                                  //         key: Key(index.toString()),
                                  //         child: Padding(
                                  //           padding: EdgeInsets.symmetric(
                                  //               vertical: 5 * Scale.height),
                                  //           child: Row(
                                  //             crossAxisAlignment:
                                  //                 CrossAxisAlignment.center,
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment
                                  //                     .spaceBetween,
                                  //             children: [
                                  //               SizedBox(
                                  //                   width: 50 * Scale.width,
                                  //                   height:
                                  //                       50 * Scale.width,
                                  //                   child: context
                                  //                           .read<PhotoBloc>()
                                  //                           .state
                                  //                           .basicPhoto[
                                  //                       index]['image']),
                                  //               Padding(
                                  //                 padding: EdgeInsets.only(
                                  //                     right:
                                  //                         20 * Scale.width),
                                  //                 child: Container(
                                  //                   alignment:
                                  //                       Alignment.center,
                                  //                   height:
                                  //                       70 * Scale.height,
                                  //                   child: Row(
                                  //                     mainAxisAlignment:
                                  //                         MainAxisAlignment
                                  //                             .center,
                                  //                     crossAxisAlignment:
                                  //                         CrossAxisAlignment
                                  //                             .center,
                                  //                     children: [
                                  //                       Text("이미지 $index",
                                  //                           style: textStyle(
                                  //                               Colors.grey[
                                  //                                   500]!,
                                  //                               FontWeight
                                  //                                   .w500,
                                  //                               'Pretendard',
                                  //                               16 *
                                  //                                   Scale
                                  //                                       .width)),
                                  //                       SizedBox(
                                  //                           width: 5 *
                                  //                               Scale
                                  //                                   .width),
                                  //                       Align(
                                  //                         alignment:
                                  //                             Alignment
                                  //                                 .center,
                                  //                         child:
                                  //                             GestureDetector(
                                  //                           onTap: () {
                                  //                             context
                                  //                                 .read<
                                  //                                     PhotoBloc>()
                                  //                                 .add(ClickBasicPhotoRemoveEvent(
                                  //                                     photoIndex:
                                  //                                         index));
                                  //                           },
                                  //                           child: Icon(
                                  //                             Icons.clear,
                                  //                             size: 20 *
                                  //                                 Scale
                                  //                                     .width,
                                  //                           ),
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ],
                                  //           ),
                                  //         ),
                                  //       );
                                  //     },
                                  //     itemCount: context
                                  //         .read<PhotoBloc>()
                                  //         .state
                                  //         .basicPhoto
                                  //         .length,
                                  //     onReorder:
                                  //         (int oldIndex, int newIndex) {
                                  //       context.read<PhotoBloc>().add(
                                  //           ReorderPhotoEvent(
                                  //               oldIndex: oldIndex,
                                  //               newIndex: newIndex));
                                  //     })
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
                          .selectedColorMap
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
                          color['customedName'],
                          style: textStyle(Colors.black, FontWeight.w500,
                              "Pretendard", 12.0),
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
                                          index: colorTabController.index));
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
                                                "Pretendard",
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
                                                  "Pretendard",
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
          return BlocBuilder<SizeBloc, SizeState>(
            builder: (context, state) {
              if (context.read<SizeBloc>().state.sizeList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "사이즈 선택(필수)",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "Pretendard", 18.0),
                    ),
                    SizedBox(height: 10 * Scale.height),
                    Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 50 * Scale.height,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: ListView.builder(
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
                                                    "Pretendard",
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
                              }),
                        ),
                        BlocBuilder<SizeBloc, SizeState>(
                          builder: (context, state) {
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const ScrollPhysics(),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 17 * Scale.width,
                                  vertical: 15 * Scale.height),
                              itemCount: context
                                  .read<SizeBloc>()
                                  .state
                                  .sizeList
                                  .length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
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
                                                  .contains(
                                                      state.sizeList[index])
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
                                                        state.sizeList[index]
                                                            ['name'])
                                                ? Colors.black
                                                : Colors.grey[400]!,
                                            FontWeight.w500,
                                            "Pretendard",
                                            13.0),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    if (context
                                        .read<SizeBloc>()
                                        .state
                                        .selectedSize
                                        .contains(
                                            state.sizeList[index]['name'])) {
                                      context.read<SizeBloc>().add(
                                          ClickRemoveSizeButton(
                                              size: state.sizeList[index]
                                                  ['name'],
                                              sizeId: state.sizeList[index]
                                                  ['id']));
                                    } else {
                                      context.read<SizeBloc>().add(
                                          ClickSizeButton(
                                              size: state.sizeList[index]
                                                  ['name'],
                                              sizeId: state.sizeList[index]
                                                  ['id']));
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
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "Pretendard", 10.0)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text("허리둘레",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "Pretendard", 10.0)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text("힙둘레",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "Pretendard", 10.0)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text("밑위길이",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "Pretendard", 10.0)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text("허벅지둘레",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "Pretendard", 10.0)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text("밑단둘레",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "Pretendard", 10.0)),
                            ),
                          ),
                          TableCell(
                            child: Center(
                              child: Text("총길이",
                                  style: textStyle(Colors.black,
                                      FontWeight.w500, "Pretendard", 10.0)),
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
          "옵션별 재고,단가 등록",
          style: textStyle(Colors.black, FontWeight.w600, "Pretendard", 17.0),
        ),
        Divider(
          color: Colors.black,
          thickness: 2 * Scale.height,
        ),
        Text(
          "재고 수량을 적어주시면 더 많은 리스트에 노출 됩니다. (미 작성시 수량은 무제한으로 간주합니다.)",
          style:
              textStyle(Colors.grey[600]!, FontWeight.w500, "Pretendard", 11.0),
        ),
        SizedBox(height: 10 * Scale.height),
        BlocBuilder<PricePerOptionBloc, PricePerOptionState>(
          builder: (context, state) {
            if (BlocProvider.of<ColorBloc>(context)
                    .state
                    .selectedColorList
                    .isNotEmpty &&
                BlocProvider.of<SizeBloc>(context)
                    .state
                    .selectedSize
                    .isNotEmpty &&
                BlocProvider.of<PriceBloc>(context).state.price.isNotEmpty &&
                context
                    .read<PricePerOptionBloc>()
                    .state
                    .pricePerOptionList
                    .isNotEmpty) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListView.builder(
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
                                border: Border.all(
                                    color: context
                                            .read<PricePerOptionBloc>()
                                            .state
                                            .inappositePriceIndexList
                                            .contains(index)
                                        ? Colors.red
                                        : Colors.grey[300]!),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 22 * Scale.width,
                                  vertical: 20 * Scale.height),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: const Icon(Icons.clear, size: 15),
                                    onTap: () {
                                      context.read<PricePerOptionBloc>().add(
                                          ClickedRemovePricePerOptionEvent(
                                              index));
                                    },
                                  ),
                                  Text(
                                    context
                                            .read<PricePerOptionBloc>()
                                            .state
                                            .pricePerOptionList[index]['color']
                                        ['customedName'],
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "Pretendard", 14.0),
                                  ),
                                  Text(
                                    context
                                            .read<PricePerOptionBloc>()
                                            .state
                                            .pricePerOptionList[index]['size']
                                        ['name'],
                                    style: textStyle(Colors.black,
                                        FontWeight.w500, "Pretendard", 14.0),
                                  ),
                                  SizedBox(
                                    width: 60 * Scale.width,
                                    height: 35 * Scale.height,
                                    child: BlocBuilder<PricePerOptionBloc,
                                        PricePerOptionState>(
                                      builder: (context, state) {
                                        return TextFormField(
                                          key: Key(index.toString()),
                                          controller: state
                                              .inventoryControllerList[index],
                                          keyboardType: TextInputType.number,
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              context
                                                  .read<PricePerOptionBloc>()
                                                  .add(InputInventoryEvent(
                                                      index: index,
                                                      inventory:
                                                          int.parse(value)));
                                            }
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
                                            fontFamily: "Pretendard",
                                            fontSize: 13.0,
                                          ),
                                          maxLength: 8,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            contentPadding: EdgeInsets.zero,
                                            hintStyle: textStyle(
                                                const Color(0xffcccccc),
                                                FontWeight.w500,
                                                "Pretendard",
                                                11.0),
                                            border: const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              borderSide: BorderSide(
                                                  color: Color(0xffcccccc),
                                                  width: 1),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              borderSide: BorderSide(
                                                  color: Color(0xffcccccc),
                                                  width: 1),
                                            ),
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      },
                                    ),
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
                ],
              );
            } else {
              return Container();
            }
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
          style: textStyle(Colors.black, FontWeight.w600, "Pretendard", 17.0),
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
                  Colors.grey[600]!, FontWeight.w500, "Pretendard", 11.0),
            ),
          ),
        ),
        BlocBuilder<FabricBloc, FabricState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.read<FabricBloc>().state.sum == 100 ||
                        context.read<FabricBloc>().state.sum == 0
                    ? Container()
                    : Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 10 * Scale.height),
                        child: Text(
                          "혼용률의 합은 100이어야 합니다!",
                          style: textStyle(
                              Colors.red, FontWeight.w500, "Pretendard", 13),
                        ),
                      ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: context.read<FabricBloc>().state.fabricList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 8 * Scale.width),
                              child: SizedBox(
                                height: 50 * Scale.height,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                                .fabricList[
                                                            index]['name'],
                                                        fabricIndex: index));
                                              },
                                            ),
                                          ),
                                        ),
                                        Text(
                                          context
                                              .read<FabricBloc>()
                                              .state
                                              .fabricList[index]['name'],
                                          style: textStyle(
                                              Colors.black,
                                              FontWeight.w500,
                                              "Pretendard",
                                              13.0),
                                        ),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        final fabricBloc =
                                            BlocProvider.of<FabricBloc>(
                                                context);
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            TextEditingController
                                                nameController =
                                                TextEditingController();
                                            return BlocProvider.value(
                                              value: fabricBloc,
                                              child: AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0)),
                                                title: Text(
                                                  "소재 편집",
                                                  style: textStyle(
                                                      Colors.black,
                                                      FontWeight.w500,
                                                      'Pretendard',
                                                      20.0),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: TextFormField(
                                                    controller: nameController,
                                                    onFieldSubmitted: (value) {
                                                      currentFocus.unfocus();
                                                    },
                                                    style: const TextStyle(
                                                      color: Color(0xff666666),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Pretendard",
                                                      fontSize: 13.0,
                                                    ),
                                                    decoration: InputDecoration(
                                                      counterText: "",
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      hintText:
                                                          "원하는 소재 이름을 작성해주세요",
                                                      hintStyle: textStyle(
                                                          const Color(
                                                              0xffcccccc),
                                                          FontWeight.w500,
                                                          "Pretendard",
                                                          14.0),
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffcccccc),
                                                            width: 1),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5)),
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xffcccccc),
                                                            width: 1),
                                                      ),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  BlocBuilder<FabricBloc,
                                                      FabricState>(
                                                    builder: (context, state) {
                                                      return TextButton(
                                                        child: Text(
                                                          "적용",
                                                          style: textStyle(
                                                              Colors.grey,
                                                              FontWeight.w400,
                                                              'Pretendard',
                                                              16.0),
                                                        ),
                                                        onPressed: () {
                                                          BlocProvider.of<
                                                                      FabricBloc>(
                                                                  context)
                                                              .add(EditFabricsNameEvent(
                                                                  fabricIndex:
                                                                      index,
                                                                  fabricName:
                                                                      nameController
                                                                          .text));
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text(
                                                      "취소",
                                                      style: textStyle(
                                                          Colors.grey,
                                                          FontWeight.w400,
                                                          'Pretendard',
                                                          16.0),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                          child: Text(
                                        "소재 편집",
                                        style: textStyle(
                                            Colors.grey,
                                            FontWeight.w400,
                                            "Pretendard",
                                            12.0),
                                      )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: 8 * Scale.width,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    width: 90 * Scale.width,
                                    height: 40 * Scale.height,
                                    child: TextFormField(
                                      controller: state.textController[index],
                                      keyboardType: TextInputType.number,
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
                                        fontFamily: "Pretendard",
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
                                            "Pretendard",
                                            11.0),
                                        border: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              color: Color(0xffcccccc),
                                              width: 1),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                          borderSide: BorderSide(
                                              color: Color(0xffcccccc),
                                              width: 1),
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
                ),
              ],
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
                        Colors.black, FontWeight.w500, "Pretendard", 12.0),
                  ),
                ),
                SizedBox(
                  width: 15 * Scale.width,
                  child: Radio<dynamic>(
                    value: type == 'lining'
                        ? selectList![index]['value']
                        : selectList?[index],
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
                        Colors.black, FontWeight.w700, "Pretendard", 18.0),
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
                                          FontWeight.w500, "Pretendard", 14.0),
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
                                          FontWeight.w500, "Pretendard", 14.0),
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
                                          FontWeight.w500, "Pretendard", 14.0),
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
                                          FontWeight.w500, "Pretendard", 14.0),
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
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (context.read<CategoryBloc>().state.selectedSubCategory.isNotEmpty) {
          return BlocBuilder<LaundryBloc, LaundryState>(
            builder: (context, state) {
              if (context.read<LaundryBloc>().state.washingList.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "세탁정보 선택",
                      style: textStyle(
                          Colors.black, FontWeight.w700, "Pretendard", 14.0),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(vertical: 15 * Scale.height),
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
                                    "Pretendard",
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
              } else {
                return Container();
              }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "스타일",
            style: textStyle(Colors.black, FontWeight.w600, "Pretendard", 17.0),
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
                  textStyle(Colors.black, FontWeight.w500, "Pretendard", 12.0),
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
                                                .selectedStyle['name'] ==
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
                                    "Pretendard", 13.0),
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

  Widget manufactureCountryArea() {
    return BlocBuilder<ManufacturecountryBloc, ManufacturecountryState>(
      builder: (context, state) {
        if (context.read<InititemBloc>().state.fetchState ==
            FetchState.success) {
          return BlocBuilder<InititemBloc, InititemState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "제조국",
                    style: textStyle(
                        Colors.black, FontWeight.w600, "Pretendard", 17.0),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
                    itemCount: context
                        .read<ManufacturecountryBloc>()
                        .state
                        .countryList
                        .length,
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
                                            .read<ManufacturecountryBloc>()
                                            .state
                                            .selectedCountry ==
                                        context
                                            .read<ManufacturecountryBloc>()
                                            .state
                                            .countryList[index]
                                    ? Colors.indigo[400]!
                                    : Colors.grey[300]!),
                          ),
                          child: Center(
                            child: Text(
                              context
                                  .read<ManufacturecountryBloc>()
                                  .state
                                  .countryList[index],
                              style: textStyle(
                                  context
                                              .read<ManufacturecountryBloc>()
                                              .state
                                              .selectedCountry ==
                                          context
                                              .read<ManufacturecountryBloc>()
                                              .state
                                              .countryList[index]
                                      ? Colors.black
                                      : Colors.grey[400]!,
                                  FontWeight.w500,
                                  "Pretendard",
                                  13.0),
                            ),
                          ),
                        ),
                        onTap: () {
                          final countryBloc =
                              BlocProvider.of<ManufacturecountryBloc>(context);
                          if (countryBloc.state.countryList[index] == '기타') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController contryController =
                                    TextEditingController();
                                return BlocProvider.value(
                                  value: countryBloc,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    title: Text(
                                      "제조국 추가",
                                      style: textStyle(Colors.black,
                                          FontWeight.w500, 'Pretendard', 20.0),
                                    ),
                                    content: SingleChildScrollView(
                                      child: TextFormField(
                                        controller: contryController,
                                        onFieldSubmitted: (value) {
                                          currentFocus.unfocus();
                                        },
                                        style: const TextStyle(
                                          color: Color(0xff666666),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Pretendard",
                                          fontSize: 13.0,
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding: EdgeInsets.zero,
                                          hintText: "제조국명을 작성해주세요",
                                          hintStyle: textStyle(
                                              const Color(0xffcccccc),
                                              FontWeight.w500,
                                              "Pretendard",
                                              14.0),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                                color: Color(0xffcccccc),
                                                width: 1),
                                          ),
                                          focusedBorder:
                                              const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            borderSide: BorderSide(
                                                color: Color(0xffcccccc),
                                                width: 1),
                                          ),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      BlocBuilder<ManufacturecountryBloc,
                                          ManufacturecountryState>(
                                        builder: (context, state) {
                                          return TextButton(
                                            child: Text(
                                              "적용",
                                              style: textStyle(
                                                  Colors.grey,
                                                  FontWeight.w400,
                                                  'Pretendard',
                                                  16.0),
                                            ),
                                            onPressed: () {
                                              BlocProvider.of<
                                                          ManufacturecountryBloc>(
                                                      context)
                                                  .add(EditCountryEvent(
                                                      country: contryController
                                                          .text));
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                      ),
                                      TextButton(
                                        child: Text(
                                          "취소",
                                          style: textStyle(
                                              Colors.grey,
                                              FontWeight.w400,
                                              'Pretendard',
                                              16.0),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else {
                            context.read<ManufacturecountryBloc>().add(
                                SelectCountryEvent(
                                    country: context
                                        .read<ManufacturecountryBloc>()
                                        .state
                                        .countryList[index]));
                          }
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

  Widget ageGroupArea() {
    return BlocBuilder<AgeGroupBloc, AgeGroupState>(
      builder: (context, state) {
        if (context.read<InititemBloc>().state.fetchState ==
            FetchState.success) {
          return BlocBuilder<InititemBloc, InititemState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "타겟 연령층",
                  style: textStyle(
                      Colors.black, FontWeight.w600, "Pretendard", 17.0),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2 * Scale.height,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.symmetric(vertical: 15 * Scale.height),
                  itemCount:
                      context.read<AgeGroupBloc>().state.ageGroupList.length,
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
                                          .read<AgeGroupBloc>()
                                          .state
                                          .selectedAgeGroupId ==
                                      context
                                          .read<AgeGroupBloc>()
                                          .state
                                          .ageGroupList[index]['id']
                                  ? Colors.indigo[400]!
                                  : Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Text(
                            context
                                .read<AgeGroupBloc>()
                                .state
                                .ageGroupList[index]['name'],
                            style: textStyle(
                                context
                                            .read<AgeGroupBloc>()
                                            .state
                                            .selectedAgeGroupId ==
                                        context
                                            .read<AgeGroupBloc>()
                                            .state
                                            .ageGroupList[index]['id']
                                    ? Colors.black
                                    : Colors.grey[400]!,
                                FontWeight.w500,
                                "Pretendard",
                                13.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        context
                            .read<AgeGroupBloc>()
                            .add(ClickAgeGroupButtonEvent(index: index));
                      },
                    );
                  },
                ),
              ],
            );
          });
        } else {
          return Container();
        }
      },
    );
  }

  Widget searchTagArea() {
    TextEditingController tagController = TextEditingController();
    return BlocConsumer<TagBloc, TagState>(
      listener: ((context, state) {
        switch (state.fetchState) {
          case FetchState.error:
            BlocProvider.of<NetworkConnectionBloc>(context)
                .add(InactiveNetworkEvent());
            break;
          default:
            BlocProvider.of<NetworkConnectionBloc>(context)
                .add(ActiveNetworkEvent());
        }
      }),
      builder: (context, state) {
        if (context.read<InititemBloc>().state.fetchState ==
            FetchState.success) {
          return BlocBuilder<InititemBloc, InititemState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "태그 입력",
                  style: textStyle(
                      Colors.black, FontWeight.w600, "Pretendard", 17.0),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2 * Scale.height,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12 * Scale.height),
                  child: Text(
                    "태그를 등록하면 더 많은 곳에 추가 노출 됩니다.",
                    style: textStyle(
                        Colors.black, FontWeight.w500, "Pretendard", 12.0),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 250 * Scale.width,
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          currentFocus.unfocus();
                        },
                        onChanged: (value) {
                          context
                              .read<TagBloc>()
                              .add(ChangeSearchTagTextEvent(searchTag: value));
                        },
                        controller: tagController,
                        style: const TextStyle(
                          color: Color(0xff666666),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Pretendard",
                          fontSize: 13.0,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding:
                              EdgeInsets.only(left: 15 * Scale.width),
                          hintText: "태그를 입력해주세요",
                          hintStyle: textStyle(const Color(0xffcccccc),
                              FontWeight.w500, "Pretendard", 14.0),
                          border: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffcccccc), width: 1),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffcccccc), width: 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10 * Scale.width),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<TagBloc>(context)
                            .add(AddTagEvent(tag: tagController.text));
                        tagController.text = '';
                      },
                      child: Container(
                          width: 60 * Scale.width,
                          height: 50 * Scale.height,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(
                                  color: const Color(0xffcccccc), width: 1)),
                          child: Center(
                            child: Text("등록",
                                style: textStyle(Colors.black, FontWeight.w400,
                                    "Pretendard", 13.0)),
                          )),
                    )
                  ],
                ),
                context.read<TagBloc>().state.tagsList.isEmpty
                    ? Container()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount:
                            context.read<TagBloc>().state.tagsList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              context.read<TagBloc>().add(AutoCompleteEvent(
                                  index: index, tagController: tagController));
                            },
                            child: Container(
                              height: 35 * Scale.height,
                              width: 250 * Scale.width,
                              color: Colors.grey[50],
                              child: Text(
                                BlocProvider.of<TagBloc>(context)
                                    .state
                                    .tagsList[index]['name'],
                                style: textStyle(Colors.black, FontWeight.w400,
                                    "Pretendard", 14.0),
                              ),
                            ),
                          );
                        },
                      ),
                const Divider(thickness: 1.5),
                BlocBuilder<TagBloc, TagState>(builder: (context, state) {
                  return SizedBox(
                    height: 40 * Scale.height,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount:
                          context.read<TagBloc>().state.selectedTags.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0 * Scale.width),
                          child: SizedBox(
                            height: 30 * Scale.height,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  context
                                      .read<TagBloc>()
                                      .state
                                      .selectedTags[index]['name'],
                                  style: textStyle(Colors.black,
                                      FontWeight.w400, "Pretendard", 13.0),
                                ),
                                InkWell(
                                  child: const Icon(Icons.clear),
                                  onTap: () {
                                    context
                                        .read<TagBloc>()
                                        .add(RemoveTagEvent(index: index));
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                })
              ],
            );
          });
        } else {
          return Container();
        }
      },
    );
  }

  Widget themeArea() {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (context.read<InititemBloc>().state.fetchState ==
            FetchState.success) {
          return BlocBuilder<InititemBloc, InititemState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "테마 선택",
                  style: textStyle(
                      Colors.black, FontWeight.w600, "Pretendard", 17.0),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 2 * Scale.height,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 17 * Scale.width,
                      vertical: 15 * Scale.height),
                  itemCount: context.read<ThemeBloc>().state.themeList.length,
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
                                          .read<ThemeBloc>()
                                          .state
                                          .selectedTheme ==
                                      context
                                          .read<ThemeBloc>()
                                          .state
                                          .themeList[index]['id']
                                  ? Colors.indigo[400]!
                                  : Colors.grey[300]!),
                        ),
                        child: Center(
                          child: Text(
                            context.read<ThemeBloc>().state.themeList[index]
                                ['name'],
                            style: textStyle(
                                context.read<ThemeBloc>().state.selectedTheme ==
                                        context
                                            .read<ThemeBloc>()
                                            .state
                                            .themeList[index]['id']
                                    ? Colors.black
                                    : Colors.grey[400]!,
                                FontWeight.w500,
                                "Pretendard",
                                13.0),
                          ),
                        ),
                      ),
                      onTap: () {
                        context.read<ThemeBloc>().add(ChangeThemeEvent(
                            themeId: context
                                .read<ThemeBloc>()
                                .state
                                .themeList[index]['id']));
                      },
                    );
                  },
                ),
              ],
            );
          });
        } else {
          return Container();
        }
      },
    );
  }

  Widget registryButton() {
    final dataGatherBloc = BlocProvider.of<DataGatherBloc>(context);
    return BlocConsumer<DataGatherBloc, DataGatherState>(
      listener: ((context, state) {
        if (state.gatherState == GatherState.success) {
          showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
              value: dataGatherBloc,
              child: BlocBuilder<DataGatherBloc, DataGatherState>(
                builder: (context, state) {
                  return AlertDialog(
                    content: Text(
                      "상품을 등록하시겠습니까?",
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'Pretendard', 16.0),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          "확인",
                          style: textStyle(Colors.black, FontWeight.w500,
                              'Pretendard', 15.0),
                        ),
                        onPressed: () {
                          BlocProvider.of<DataGatherBloc>(context)
                              .add(RegistEvent(registMode: widget.registMode));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
        if (state.registState == FetchState.success) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
              (route) => false);
        }
        if (state.fetchState == FetchState.failure) {
          showDialog(
            context: context,
            builder: (context) => BlocProvider.value(
              value: dataGatherBloc,
              child: BlocBuilder<DataGatherBloc, DataGatherState>(
                builder: (context, state) {
                  return AlertDialog(
                    content: Text(
                      state.error,
                      style: textStyle(
                          Colors.black, FontWeight.w500, 'Pretendard', 16.0),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          "확인",
                          style: textStyle(Colors.black, FontWeight.w500,
                              'Pretendard', 15.0),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
      }),
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context.read<DataGatherBloc>().add(CombineDataEvent(
                  registMode: widget.registMode,
                ));
          },
          child: Container(
              height: 70 * Scale.height,
              width: 414 * Scale.width,
              color: Colors.indigo[500],
              child: Center(
                child: Text(
                  "다음",
                  style: textStyle(
                      Colors.white, FontWeight.w500, "Pretendard", 20.0),
                ),
              )),
        );
      },
    );
  }
}
