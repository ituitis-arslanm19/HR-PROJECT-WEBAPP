import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/profile_card.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';

import '../../core/widgets/other/indicator.dart';

class DepartmentdDetailView extends StatelessWidget {
  const DepartmentdDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                SizeConfig.horizontalSpace(),
                Text(
                  "İnsan Kaynakları",
                  style: theme.textTheme.headlineLarge!
                      .copyWith(color: colorScheme.primary),
                ),
                SizeConfig.horizontalSpace(),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 9,
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SimpleContainer(
                            title: "Departman Bilgileri",
                            child: Column(
                              children: [
                                ProfileCard(
                                  tittle: "Çalışan Sayısı",
                                ),
                                ProfileCard(
                                  tittle: "Üst Departman",
                                ),
                                ProfileCard(
                                  tittle: "Alt Departman",
                                )
                              ],
                            )),
                      ),
                      Expanded(
                        flex: 5,
                        child: SimpleContainer(
                            title: "Yönetici Bilgileri",
                            child: Column(
                              children: [
                                ProfileCard(
                                  tittle: "İsim",
                                ),
                                ProfileCard(
                                  tittle: "E-posta",
                                ),
                                ProfileCard(
                                  tittle: "Başlangıç Tarihi",
                                )
                              ],
                            )),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: SimpleContainer(
                            title: "Çalışan Listesi",
                            child: Container(
                                height: SizeConfig.blockSizeVertical * 26,
                                child: ListWidget(
                                  titles: [],
                                  data: [
                                    [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundColor: colorScheme.primary,
                                          child: Text("Çİ",
                                              style: theme
                                                  .textTheme.headlineSmall!
                                                  .copyWith(
                                                      color: colorScheme
                                                          .background)),
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                      ),
                                      Text("Çalışan İsmi"),
                                      Text("01/01/2000")
                                    ],
                                    [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundColor: colorScheme.primary,
                                          child: Text("Çİ",
                                              style: theme
                                                  .textTheme.headlineSmall!
                                                  .copyWith(
                                                      color: colorScheme
                                                          .background)),
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                      ),
                                      Text("Çalışan İsmi"),
                                      Text("01/01/2000")
                                    ],
                                    [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundColor: colorScheme.primary,
                                          child: Text("Çİ",
                                              style: theme
                                                  .textTheme.headlineSmall!
                                                  .copyWith(
                                                      color: colorScheme
                                                          .background)),
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                      ),
                                      Text("Çalışan İsmi"),
                                      Text("01/01/2000")
                                    ],
                                    [
                                      Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: CircleAvatar(
                                          backgroundColor: colorScheme.primary,
                                          child: Text("Çİ",
                                              style: theme
                                                  .textTheme.headlineSmall!
                                                  .copyWith(
                                                      color: colorScheme
                                                          .background)),
                                          radius:
                                              SizeConfig.blockSizeHorizontal *
                                                  3,
                                        ),
                                      ),
                                      Text("Çalışan İsmi"),
                                      Text("01/01/2000")
                                    ]
                                  ],
                                ))),
                      ),
                      Expanded(
                        flex: 5,
                        child: Center(
                            child: buildGenderPieChart(colorScheme, theme)),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }

  SimpleContainer buildGenderPieChart(
      ColorScheme colorScheme, ThemeData theme) {
    return SimpleContainer(
        title: "Cinsiyet Dağılımı",
        child: SizedBox(
          child: SizedBox(
            height: SizeConfig.blockSizeVertical * 25,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Observer(builder: (_) {
                    return PieChart(
                      PieChartData(
                        centerSpaceRadius: SizeConfig.blockSizeVertical * 6,
                        sections: showingGenderSections(
                          colorScheme,
                          theme,
                        ),
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              //homeViewModel.pieChartIndex1 = -1;
                              return;
                            }
                            // homeViewModel.changePieChartIndex1(pieTouchResponse
                            //   .touchedSection!.touchedSectionIndex);
                          },
                        ),
                      ),
                    );
                  }),
                ),
                Expanded(
                    flex: 5,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Indicator(
                                  color: colorScheme.primary,
                                  text: "Erkek",
                                  isSquare: true),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text(
                                "40",
                                style: theme.textTheme.bodySmall,
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text(
                                "%40",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: SizeConfig.blockSizeVertical * 1),
                          Row(
                            children: [
                              Indicator(
                                  color: colorScheme.secondary,
                                  text: "Kadın",
                                  isSquare: true),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text(
                                "40",
                                style: theme.textTheme.bodySmall,
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 2,
                              ),
                              Text(
                                "%40",
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }

  List<PieChartSectionData> showingGenderSections(
    ColorScheme colorScheme,
    ThemeData theme,
  ) {
    return List.generate(2, (i) {
      final isTouched = 3 == i;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 50.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: colorScheme.primary,
            value: 40,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: colorScheme.secondary,
            value: 60,
            radius: radius,
          );

        default:
          throw Error();
      }
    });
  }
}
