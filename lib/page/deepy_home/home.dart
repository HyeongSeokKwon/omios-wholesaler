import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/scroll_area.dart';
import 'package:deepy_wholesaler/repository/mypage_repository.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MypageBloc(mypageRepository: MypageRepository()),
      child: const Scaffold(
        body: ScrollArea(),
      ),
    );
  }
}
