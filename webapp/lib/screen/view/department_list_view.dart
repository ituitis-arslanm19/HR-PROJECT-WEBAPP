import 'package:flutter/material.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_card.dart';
import 'package:webapp/core/widgets/other/search_field.dart';

class DepartmentListView extends StatelessWidget {
  DepartmentListView({super.key});

  List<String> names = [
    "İnsan Kaynakları",
    "Yazılım ve IT",
    "Yönetim",
    "Finans",
    "İnsan Kaynakları",
    "Yazılım ve IT",
    "Yönetim",
    "Finans",
    "İnsan Kaynakları",
    "Yazılım ve IT",
    "Yönetim",
    "Finans",
    "İnsan Kaynakları",
    "Yazılım ve IT",
    "Yönetim",
    "Finans"
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SizeConfig.blockSizeHorizontal * 10.5,
        right: SizeConfig.blockSizeHorizontal * 10.5,
      ),
      child: Column(children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 3,
                right: SizeConfig.blockSizeHorizontal * 3,
                top: SizeConfig.blockSizeHorizontal * 1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SearchField(
                    textEditingController: TextEditingController(),
                    onChanged: (text) {},
                  ),
                ],
              ),
            )),
        Expanded(
          flex: 19,
          child: ListView.builder(
              itemCount: names.length ~/ 3 + 1,
              itemBuilder: ((context, index) {
                return Container(
                  child: Row(
                    children: [
                      ...index * 3 + 3 < names.length
                          ? names
                              .sublist(index * 3, index * 3 + 3)
                              .map((e) => Padding(
                                    padding: EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 3,
                                    ),
                                    child: ListCard(
                                        onTap: () {},
                                        name: e,
                                        secondTxt: "Yönetici İsmi",
                                        thirdTxt: "145 Çalışan"),
                                  ))
                          : names
                              .sublist(index * 3, names.length)
                              .map((e) => Padding(
                                    padding: EdgeInsets.all(
                                      SizeConfig.blockSizeHorizontal * 3,
                                    ),
                                    child: ListCard(
                                        onTap: () {},
                                        name: e,
                                        secondTxt: "Yönetici İsmi",
                                        thirdTxt: "145 Çalışan"),
                                  ))
                    ],
                  ),
                );
              })),
        ),
      ]),
    );
  }
}
