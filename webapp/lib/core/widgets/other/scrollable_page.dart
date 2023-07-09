// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';

class ScrollablePage extends StatelessWidget {
  final Widget child;
  final double? height;
  const ScrollablePage({super.key, required this.child, this.height});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: height ?? SizeConfig.screenHeight * 7 / 8,
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
