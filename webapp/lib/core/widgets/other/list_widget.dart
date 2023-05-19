// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../util/size_config.dart';

class ListWidget extends StatelessWidget {
  final List<String> titles;
  final List<List<Widget>> data;

  const ListWidget({
    Key? key,
    required this.titles,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Column(children: [
      !titles.isEmpty
          ? Container(
              decoration: BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey.shade300))),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: buildListTitle(
                    theme.textTheme.bodyMedium!
                        .copyWith(color: colorScheme.primary),
                    titles),
              ))
          : SizedBox(
              height: 0,
              width: 0,
            ),
      Expanded(child: LayoutBuilder(builder: (buildContext, constraints) {
        return SizedBox(
            height: constraints.maxHeight,
            child: buildList(colorScheme, theme));
      }))
    ]);
  }

  ListView buildList(ColorScheme colorScheme, ThemeData theme) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          height: SizeConfig.blockSizeVertical * 4,
          color: index % 2 == 0
              ? colorScheme.background
              : colorScheme.primary.withOpacity(0.05),
          child: buildListTile(
              theme.textTheme.bodySmall!.copyWith(color: theme.hintColor),
              data[index]),
        );
      },
      itemCount: data.length,
    );
  }
}

SizedBox buildListTitle(TextStyle listTextStyle, List<String> titles) {
  return SizedBox(
    height: SizeConfig.blockSizeVertical * 4,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ...titles.map((e) => Container(
              width: SizeConfig.blockSizeHorizontal * 12,
              child: Text(
                e,
                style: listTextStyle,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )),
      ],
    ),
  );
}

Row buildListTile(TextStyle listTextStyle, List<Widget> dataRow) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      ...dataRow.map(
          (e) => SizedBox(width: SizeConfig.blockSizeHorizontal * 12, child: e))
    ],
  );
}
