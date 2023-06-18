import 'package:flutter/material.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.textColor,
  });
  final Color color;
  final String? text;
  final bool isSquare;

  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Row(
      children: <Widget>[
        Container(
          width: theme.textTheme.bodySmall!.fontSize,
          height: theme.textTheme.bodySmall!.fontSize,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(text ?? "Hata", style: theme.textTheme.bodySmall)
      ],
    );
  }
}
