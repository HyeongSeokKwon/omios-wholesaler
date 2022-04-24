import 'package:deepy_wholesaler/bloc/myproducts_bloc/myproducts_bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/wholesaler_info_area.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/wholesaler_products_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScrollArea extends StatelessWidget {
  const ScrollArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyproductsBloc, MyproductsState>(
      builder: (context, state) {
        if (context.read<MyproductsBloc>().state.fetchStatus ==
            FetchStatus.error) {
          return Container();
        } else {
          return SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              children: const [
                WholeSalerInfoArea(),
                WholeSalerProductArea(),
              ],
            ),
          );
        }
      },
    );
  }
}
