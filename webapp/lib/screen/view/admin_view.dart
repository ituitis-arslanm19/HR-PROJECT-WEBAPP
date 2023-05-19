import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';

class AdminView extends StatelessWidget {
  const AdminView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Scaffold(
      body: DefaultTabController(
        length: 6,
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeVertical * 6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TabBar(
                  labelColor: colorScheme.primary,
                  labelStyle: theme.textTheme.headlineMedium,
                  indicatorColor: colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    const Tab(text: "Zimmet"),
                    const Tab(text: "Alan"),
                    const Tab(text: "Giriş Noktası"),
                    const Tab(text: "Okuyucular"),
                    const Tab(text: "Vardiya"),
                    const Tab(text: "İzin Tipi"),
                  ]),
            ),
            Expanded(child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: theme.colorScheme.background,
                      border: Border.all(color: Colors.grey.shade300)),
                  child: TabBarView(children: [
                    ListWidget(titles: [
                      "Id",
                      "Ad",
                      "Yön"
                    ], data: [
                      [Text("1"), Text("Reader1"), Text("Dışarı")],
                      [Text("1"), Text("Reader1"), Text("Dışarı")],
                      [Text("1"), Text("Reader1"), Text("Dışarı")],
                      [Text("1"), Text("Reader1"), Text("Dışarı")]
                    ]),
                    ListWidget(titles: [
                      "Id",
                      "Ad",
                      "Yön"
                    ], data: [
                      [Text("1"), Text("Reader1"), Text("Dışarı")]
                    ]),
                    ListWidget(titles: [
                      "Id",
                      "Ad",
                      "Yön"
                    ], data: [
                      [Text("1"), Text("Reader1"), Text("Dışarı")]
                    ]),
                    ListWidget(titles: [
                      "Id",
                      "Ad",
                      "Yön"
                    ], data: [
                      [Text("1"), Text("Reader1"), Text("Dışarı")]
                    ]),
                    ListWidget(titles: [
                      "Id",
                      "Ad",
                      "Yön"
                    ], data: [
                      [Text("1"), Text("Reader1"), Text("Dışarı")]
                    ]),
                    ListWidget(titles: [
                      "Id",
                      "Ad",
                      "Yön"
                    ], data: [
                      [Text("1"), Text("Reader1"), Text("Dışarı")]
                    ]),
                  ]),
                ),
              );
            }))
          ],
        ),
      ),
    );
  }
}
