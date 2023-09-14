import 'package:flutter/material.dart';
import 'package:frontend/pages/home_page.dart';

void showSnackBar(String str) {
  ScaffoldMessenger.of(scaffoldKey.currentContext!)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Center(child: Text(str)),
      width: getWidth(),
      behavior: SnackBarBehavior.floating,
      //margin: const EdgeInsets.only(left: 16, bottom: 100, right: 16),
      duration: const Duration(seconds: 2),
    ));
}

double getWidth() {
  final width = MediaQuery.of(scaffoldKey.currentContext!).size.width;
  if (width > 700) return width / 3;
  return width * 0.8;
}
