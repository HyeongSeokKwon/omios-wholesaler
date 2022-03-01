import 'package:deepy_wholesaler/bloc/myproducts_bloc/myproducts_bloc.dart';
import 'package:deepy_wholesaler/model/product_model.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/util.dart';
import '../../../widget/product_card.dart';

class WholeSalerProductArea extends StatelessWidget {
  const WholeSalerProductArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyproductsBloc, MyproductsState>(
        listener: ((context, state) {
      switch (state.fetchStatus) {
        case FetchStatus.unfetched:
          BlocProvider.of<MyproductsBloc>(context).add(LoadMyproductsEvent());
          break;
        default:
          break;
      }
    }), builder: (context, state) {
      if (state.fetchStatus == FetchStatus.fetched) {
        return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 0),
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: context.read<MyproductsBloc>().state.productsData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, int index) {
            return ProductCard(
                product: Product.fromJson(
                    context.read<MyproductsBloc>().state.productsData[index]),
                imageWidth: 110 * Scale.width);
          },
        );
      } else {
        context.read<MyproductsBloc>().add(LoadMyproductsEvent());
        return progressBar();
      }
    });
  }
}
