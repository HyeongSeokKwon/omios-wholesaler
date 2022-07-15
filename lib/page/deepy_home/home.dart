import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/scroll_area.dart';
import 'package:deepy_wholesaler/repository/mypage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';
import '../mypage/mypage.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final InfinityScrollBloc infinityScrollBloc = InfinityScrollBloc();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => MypageBloc(
              mypageRepository: MypageRepository(),
              infinityBloc: infinityScrollBloc),
        ),
        BlocProvider<InfinityScrollBloc>(
          create: (BuildContext context) => infinityScrollBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 22 * Scale.width),
              child: GestureDetector(
                onTap: () {},
                child: SvgPicture.asset("assets/images/svg/alarm.svg",
                    width: 26 * Scale.width, height: 26 * Scale.height),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 22 * Scale.width),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Mypage()),
                  );
                },
                child: SvgPicture.asset("assets/images/svg/myPage.svg",
                    width: 26 * Scale.width, height: 26 * Scale.height),
              ),
            )
          ],
          titleSpacing: 0.0,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: const ScrollArea(),
      ),
    );
  }
}
