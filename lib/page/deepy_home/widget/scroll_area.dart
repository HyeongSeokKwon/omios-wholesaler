import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/wholesaler_info_area.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/wholesaler_products_area.dart';
import 'package:deepy_wholesaler/widget/progress_bar.dart';
import 'package:flutter/material.dart';

class ScrollArea extends StatefulWidget {
  const ScrollArea({Key? key}) : super(key: key);

  @override
  State<ScrollArea> createState() => _ScrollAreaState();
}

class _ScrollAreaState extends State<ScrollArea> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset ==
          scrollController.position.maxScrollExtent) {
        context.read<InfinityScrollBloc>().add(AddDataEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MypageBloc, MypageState>(
      builder: (context, state) {
        if (context.read<MypageBloc>().state.fetchStatus == FetchStatus.error) {
          return Container();
        } else if (context.read<MypageBloc>().state.fetchStatus ==
            FetchStatus.unfetched) {
          context.read<MypageBloc>().add(LoadMyProductsEvent());
          return progressBar();
        } else {
          return SingleChildScrollView(
            controller: scrollController,
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
