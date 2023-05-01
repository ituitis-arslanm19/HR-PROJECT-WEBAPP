import 'package:flutter/widgets.dart';
import 'dart:html' as html;

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;

  void init(BuildContext context) {
    screenWidth = html.window.screen!.width!.toDouble();
    screenHeight = screenWidth = html.window.screen!.height!.toDouble();

    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}
