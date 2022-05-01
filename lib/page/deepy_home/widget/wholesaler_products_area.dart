import 'package:deepy_wholesaler/model/product_model.dart';
import 'package:deepy_wholesaler/page/edit_product/edit_product.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/material.dart';

import '../../../bloc/bloc.dart';
import '../../../util/util.dart';
import '../../../widget/product_card.dart';

class WholeSalerProductArea extends StatelessWidget {
  const WholeSalerProductArea({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MypageBloc, MypageState>(builder: (context, state) {
      if (state.fetchStatus == FetchStatus.fetched) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: context.read<MypageBloc>().state.productsData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, int index) {
            int productId =
                context.read<MypageBloc>().state.productsData[index]['id'];
            return InkWell(
              child: ProductCard(
                  product: Product.fromJson(
                      context.read<MypageBloc>().state.productsData[index]),
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
        );
      } else if (state.fetchStatus == FetchStatus.error) {
        return progressBar();
      } else {
        context.read<MypageBloc>().add(LoadMyProductsEvent());
        return progressBar();
      }
    });
  }
}
