import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/material.dart';

class ErrorCard extends StatefulWidget {
  dynamic parentState;
  ErrorCard({Key? key, required this.parentState}) : super(key: key);

  @override
  State<ErrorCard> createState() => _ErrorCardState();
}

class _ErrorCardState extends State<ErrorCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "네트워크에 연결하지 못했어요",
            style: textStyle(Colors.black, FontWeight.w700, "NotoSansKR", 20.0),
          ),
          Text(
            "네트워크 연결상태를 확인하고",
            style: textStyle(Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
          ),
          Text(
            "다시 시도해 주세요",
            style: textStyle(Colors.grey, FontWeight.w500, "NotoSansKR", 13.0),
          ),
          SizedBox(height: 15 * Scale.height),
          InkWell(
            onTap: () {
              widget.parentState.setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius:
                      const BorderRadiusDirectional.all(Radius.circular(19))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 17 * Scale.width, vertical: 14 * Scale.height),
                child: Text("다시 시도하기",
                    style: textStyle(
                        Colors.black, FontWeight.w700, 'NotoSansKR', 15.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
