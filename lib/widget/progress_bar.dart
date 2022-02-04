import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget progressBar() {
  if (Platform.isIOS) {
    return const Center(child: CupertinoActivityIndicator());
  } else {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.pink[400]!,
        ),
      ),
    );
  }
}
