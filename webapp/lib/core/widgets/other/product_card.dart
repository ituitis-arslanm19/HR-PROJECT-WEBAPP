import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String date;

  const ProductCard({super.key, required this.name, required this.date});

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
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 2,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ]),
              child: Icon(
                Icons.computer,
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
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 2,
                      offset: const Offset(0, 5), // changes position of shadow
                    ),
                  ]),
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
}
