import 'package:deepy_wholesaler/page/deepy_home/widget/wholesaler_info_area.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/wholesaler_products_area.dart';
import 'package:flutter/material.dart';

class ScrollArea extends StatelessWidget {
  const ScrollArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
