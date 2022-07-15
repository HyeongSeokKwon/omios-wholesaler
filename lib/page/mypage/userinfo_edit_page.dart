import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/util.dart';

class UserInfoEditPage extends StatefulWidget {
  const UserInfoEditPage({Key? key}) : super(key: key);

  @override
  State<UserInfoEditPage> createState() => _UserInfoEditPageState();
}

class _UserInfoEditPageState extends State<UserInfoEditPage> {
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
              "개인정보",
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
          children: [],
        ),
      ),
    );
  }
}
