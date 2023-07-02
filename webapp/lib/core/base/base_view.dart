import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';

class BaseView extends StatelessWidget {
  final Widget child;
  const BaseView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: child,
    );
  }
}
