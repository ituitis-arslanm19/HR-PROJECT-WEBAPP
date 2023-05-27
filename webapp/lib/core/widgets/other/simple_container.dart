// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:webapp/core/util/size_config.dart';

class SimpleContainer extends StatelessWidget {
  String? title;
  Widget child;
  double? padding;

  SimpleContainer({
    Key? key,
    this.title,
    required this.child,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.all(padding ?? 16.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.colorScheme.background,
            border: Border.all(color: Colors.grey.shade300)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: theme.textTheme.headlineMedium,
                  textAlign: TextAlign.left,
                ),
              if (title != null) Divider(),
              if (title != null) SizeConfig.verticalSpace(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
