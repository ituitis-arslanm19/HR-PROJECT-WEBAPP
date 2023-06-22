// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:webapp/core/util/size_config.dart';

class NavItem extends StatelessWidget {
  void Function()? onTap;
  bool isSelected;
  bool? isSubItem;
  String title;
  IconData? icon;
  IconData? endIcon;

  NavItem({
    Key? key,
    this.onTap,
    required this.isSelected,
    this.isSubItem,
    required this.title,
    this.icon,
    this.endIcon,
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
      containerColor = colorScheme.secondary;
    } else {
      color = Colors.grey;
      containerColor = Colors.transparent;
      startingColor = Colors.transparent;
    }
    return Column(
      children: [
        SizedBox(
          height: isSubItem == true
              ? SizeConfig.blockSizeVertical * 0.0
              : SizeConfig.blockSizeVertical * 1.25,
        ),
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
                      if (isSubItem != true)
                        Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(icon, color: color)),
                      Padding(
                        padding: EdgeInsets.only(
                            left: isSubItem == true ? 34 : 14.0),
                        child: Text(
                          title,
                          style: theme.textTheme.bodyMedium!.copyWith(
                              color: color, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(endIcon, color: color),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: isSubItem == true
              ? SizeConfig.blockSizeVertical * 0.0
              : SizeConfig.blockSizeVertical * 1.25,
        )
      ],
    );
  }
}
