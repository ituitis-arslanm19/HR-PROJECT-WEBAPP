import 'package:flutter/material.dart';
import 'package:webapp/core/constant/enum/enums.dart';

import '../../util/size_config.dart';

class ProductCard extends StatelessWidget {
  final String? name;
  final String? date;
  final ProductType? type;

  const ProductCard({super.key, this.name, this.date, this.type});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle tittleStyle = theme.textTheme.bodySmall!
        .copyWith(color: colorScheme.primary, fontWeight: FontWeight.bold);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              height: SizeConfig.blockSizeVertical * 12,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Icon(
                Icons.laptop,
                color: colorScheme.background,
                size: SizeConfig.blockSizeVertical * 6,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              height: SizeConfig.blockSizeVertical * 12,
              decoration: BoxDecoration(
                color: colorScheme.background,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'İsim: ',
                        style: tittleStyle,
                        /*defining default style is optional */
                        children: <TextSpan>[
                          TextSpan(
                            text: name,
                            style: theme.textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Tarih: ',
                        style: tittleStyle,
                        /*defining default style is optional */
                        children: <TextSpan>[
                          TextSpan(
                            text: date,
                            style: theme.textTheme.bodySmall,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  IconData getIcon(ProductType? productType) {
    switch (productType) {
      case ProductType.HEADPHONE:
        return Icons.headphones;
      case ProductType.KEYBOARD:
        return Icons.keyboard;
      case ProductType.MOUSE:
        return Icons.mouse;

      case ProductType.OTHER:
        return Icons.devices_other;
      default:
        return Icons.laptop;
    }
  }
}
