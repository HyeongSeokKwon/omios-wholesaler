import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpAppBar extends StatelessWidget with PreferredSizeWidget {
  const SignUpAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xffffffff),
      automaticallyImplyLeading: false,
      elevation: 0,
      leadingWidth: 414 * Scale.width,
      leading: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 20 * Scale.width),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SvgPicture.asset("assets/images/svg/moveToBack.svg")),
              SizedBox(width: 10 * Scale.width),
              Text("회원가입",
                  style: textStyle(const Color(0xff333333), FontWeight.w700,
                      "NotoSansKR", 20.0)),
            ],
          ),
        ),
      ),
    );
  }
}
