// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:webapp/core/util/size_config.dart';

class NavItem extends StatelessWidget {
  void Function()? onTap;
  bool isSelected;
  String title;
  IconData icon;

  NavItem({
    Key? key,
    this.onTap,
    required this.isSelected,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    Color color = isSelected ? colorScheme.primary : Colors.grey;
    Color containerColor;
    Color startingColor;
    if (isSelected) {
      color = colorScheme.primary;
      startingColor = color;
      containerColor = color.withOpacity(0.1);
    } else {
      color = Colors.grey;
      containerColor = Colors.transparent;
      startingColor = Colors.transparent;
    }
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                Container(
                  color: containerColor,
                  height: SizeConfig.blockSizeVertical * 5,
                  child: Row(
                    children: [
                      Container(
                        width: 5,
                        color: startingColor,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Icon(icon, color: color),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(
                          title,
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: color, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: SizeConfig.blockSizeVertical * 2.5,
        )
      ],
    );
  }
}
