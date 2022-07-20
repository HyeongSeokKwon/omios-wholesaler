import 'package:deepy_wholesaler/page/mypage/userinfo_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../bloc/mypage_bloc/mypage_bloc.dart';
import '../../util/util.dart';

class Mypage extends StatefulWidget {
  final MypageBloc mypageBloc;
  const Mypage({Key? key, required this.mypageBloc}) : super(key: key);

  @override
  State<Mypage> createState() => _MypageState();
}

class _MypageState extends State<Mypage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset("assets/images/svg/moveToBack.svg"),
            ),
            Text(
              "마이페이지",
              style:
                  textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 23.0),
            )
          ],
        ),
        titleSpacing: 0.0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [menuArea()],
        ),
      ),
    );
  }

  Widget menuArea() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20 * Scale.width, vertical: 15 * Scale.height),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserInfoEditPage(
                            mypageBloc: widget.mypageBloc,
                          )));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/images/svg/mypageQuestion.svg",
                        width: 18 * Scale.width,
                        height: 18 * Scale.width,
                        fit: BoxFit.scaleDown),
                    SizedBox(width: 16 * Scale.width),
                    Text(
                      "회원정보 확인 및 변경",
                      style: textStyle(const Color(0xff333333), FontWeight.w500,
                          "NotoSansKR", 16.0),
                    ),
                  ],
                ),
                SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
              ],
            ),
          ),
          SizedBox(height: 32 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svg/mypageQuestion.svg",
                      width: 18 * Scale.width,
                      height: 18 * Scale.width,
                      fit: BoxFit.scaleDown),
                  SizedBox(width: 16 * Scale.width),
                  Text(
                    "앱 문의",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                ],
              ),
              SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
            ],
          ),
          SizedBox(height: 32 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svg/mypageUsingTerm.svg",
                      width: 18 * Scale.width,
                      height: 18 * Scale.width,
                      fit: BoxFit.scaleDown),
                  SizedBox(width: 16 * Scale.width),
                  Text(
                    "이용약관",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                ],
              ),
              SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
            ],
          ),
          SizedBox(height: 32 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svg/mypageInfoPolicy.svg",
                      width: 18 * Scale.width,
                      height: 18 * Scale.width,
                      fit: BoxFit.scaleDown),
                  SizedBox(width: 16 * Scale.width),
                  Text(
                    "개인정보 취급방침",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                ],
              ),
              SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
            ],
          ),
          SizedBox(height: 32 * Scale.height),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/images/svg/mypageVersionInfo.svg",
                      width: 18 * Scale.width,
                      height: 18 * Scale.width,
                      fit: BoxFit.scaleDown),
                  SizedBox(width: 16 * Scale.width),
                  Text(
                    "버전정보",
                    style: textStyle(const Color(0xff333333), FontWeight.w500,
                        "NotoSansKR", 16.0),
                  ),
                ],
              ),
              SvgPicture.asset("assets/images/svg/mypageAddtionalMove.svg")
            ],
          )
        ],
      ),
    );
  }
}
