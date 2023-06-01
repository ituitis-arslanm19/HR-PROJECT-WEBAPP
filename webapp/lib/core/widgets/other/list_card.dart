// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class ListCard extends StatefulWidget {
  final String? name;
  final String? secondTxt;
  final String? thirdTxt;
  final void Function() onTap;
  const ListCard({
    Key? key,
    required this.name,
    required this.secondTxt,
    required this.thirdTxt,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ListCard> createState() => _ListCardState();
}

class _ListCardState extends State<ListCard> {
  bool state = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    final hoveredTransform = Matrix4.identity()..scale(1.1);
    final transform = state ? Matrix4.identity() : hoveredTransform;
    return AnimatedContainer(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: theme.colorScheme.background,
          border: Border.all(color: Colors.grey.shade300)),
      curve: Curves.easeInOut,
      transform: transform,
      height: SizeConfig.blockSizeVertical * 30,
      width: SizeConfig.blockSizeVertical * 30,
      duration: Duration(milliseconds: 100),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onTap,
            onHover: (onHover) {
              setState(() {
                state = !state;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizeConfig.verticalSpace(),
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey, width: 3)),
                    child: CircleAvatar(
                      backgroundColor: colorScheme.primary,
                      radius: SizeConfig.blockSizeVertical * 5,
                      child: Text(getInitials(widget.name ?? "Hata"),
                          style: theme.textTheme.headlineLarge!
                              .copyWith(color: colorScheme.background)),
                    ),
                  ),
                ),
                SizeConfig.verticalSpace(),
                Text(
                  widget.name ?? "Hata",
                  style: theme.textTheme.headlineMedium,
                ),
                SizeConfig.verticalSpace(),
                Text(
                  widget.secondTxt ?? "Hata",
                  style:
                      theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                ),
                Text(
                  widget.thirdTxt ?? "Hata",
                  style:
                      theme.textTheme.bodySmall!.copyWith(color: Colors.grey),
                ),
                SizeConfig.verticalSpace(),
              ],
            ),
          )),
    );
  }

  String getInitials(String name) => name.isNotEmpty
      ? name
          .trim()
          .split(' ')
          .map((l) => l != "ve" ? l[0] : "")
          .take(2)
          .join()
          .toUpperCase()
      : '';
}
