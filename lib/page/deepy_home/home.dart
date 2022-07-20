import 'package:deepy_wholesaler/bloc/bloc.dart';
import 'package:deepy_wholesaler/page/deepy_home/widget/scroll_area.dart';
import 'package:deepy_wholesaler/repository/mypage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    final infinityScrollBloc = InfinityScrollBloc();
    final mypageBloc = MypageBloc(
        mypageRepository: MypageRepository(), infinityBloc: infinityScrollBloc);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => mypageBloc,
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
                onTap: () async {
                  // const url = 'https://play.google.com';
                  // if (await canLaunchUrlString(url)) { // 앱스토어 or Playstore로 이동.
                  //   await launchUrlString(url);
                  // }
                },
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
                    MaterialPageRoute(
                        builder: (context) => Mypage(
                              mypageBloc: mypageBloc,
                            )),
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
