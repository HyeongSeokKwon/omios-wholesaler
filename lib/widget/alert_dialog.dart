import 'dart:io';

import 'package:deepy_wholesaler/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic showAlertDialog(BuildContext context, String eString) {
  if (Platform.isIOS) {
    print("ios alert");
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Text(eString),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("확인"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  } else {
    return showDialog(
      context: context,
      builder: (context) {
        print("android alert");
        return AlertDialog(
          content: Text(
            eString,
            style: textStyle(Colors.black, FontWeight.w500, 'NotoSansKR', 16.0),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                "확인",
                style: textStyle(
                    Colors.black, FontWeight.w500, 'NotoSansKR', 15.0),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
