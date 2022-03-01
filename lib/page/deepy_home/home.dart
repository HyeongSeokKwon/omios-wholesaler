import 'package:deepy_wholesaler/bloc/myproducts/myproducts_bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/scroll_area.dart';
import 'package:deepy_wholesaler/repository/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MyproductsBloc(productsRepository: ProductsRepository()),
      child: const Scaffold(
        body: ScrollArea(),
      ),
    );
  }
}
