import 'package:deepy_wholesaler/model/product_model.dart';
import 'package:deepy_wholesaler/page/edit_product/edit_product.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/material.dart';

import '../../../bloc/bloc.dart';
import '../../../util/util.dart';
import '../../../widget/product_card.dart';

class WholeSalerProductArea extends StatefulWidget {
  const WholeSalerProductArea({Key? key}) : super(key: key);

  @override
  State<WholeSalerProductArea> createState() => _WholeSalerProductAreaState();
}

class _WholeSalerProductAreaState extends State<WholeSalerProductArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: BlocBuilder<InfinityScrollBloc, InfinityScrollState>(
        builder: (context, state) {
          return BlocBuilder<MypageBloc, MypageState>(
              builder: (context, state) {
            if (state.fetchStatus == FetchStatus.fetched) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: 15 * Scale.height,
                        left: 20 * Scale.width,
                        right: 20 * Scale.width),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40 * Scale.height,
                            child: TextFormField(
                              onFieldSubmitted: (value) {
                                //currentFocus.unfocus();
                              },
                              onChanged: (value) {
                                context.read<MypageBloc>().add(
                                    SearchMyProductsEvent(searchWord: value));
                              },
                              style: const TextStyle(
                                color: Color(0xff666666),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Pretendard",
                                fontSize: 13.0,
                              ),
                              cursorHeight: 18 * Scale.height,
                              cursorColor: Colors.grey[600],
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.only(left: 15 * Scale.width),
                                hintText: "상품명을 검색해주세요",
                                hintStyle: textStyle(Colors.grey[500]!,
                                    FontWeight.w600, "Pretendard", 14.0),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffcccccc), width: 1),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffcccccc), width: 1),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xffcccccc), width: 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10 * Scale.width),
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: context
                        .read<InfinityScrollBloc>()
                        .state
                        .productData
                        .length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.6,
                    ),
                    itemBuilder: (context, int index) {
                      int productId = context
                          .read<InfinityScrollBloc>()
                          .state
                          .productData[index]['id'];
                      return InkWell(
                        child: ProductCard(
                            product: Product.fromJson(context
                                .read<InfinityScrollBloc>()
                                .state
                                .productData[index]),
                            imageWidth: 110 * Scale.width),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditProduct(productId: productId)));
                        },
                      );
                    },
                  ),
                ],
              );
            } else if (state.fetchStatus == FetchStatus.unfetched) {
              context.read<MypageBloc>().add(LoadMyProductsEvent());
              return progressBar();
            } else {
              return progressBar();
            }
          });
        },
      ),
    );
  }
}
