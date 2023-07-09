import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/indicator.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/screen/model/dashboard/department_pie_chart.dart';
import 'package:webapp/screen/model/dashboard/upcoming_birthday.dart';
import 'package:webapp/screen/service/home_service.dart';
import 'package:webapp/screen/view/product_view.dart';
import 'package:webapp/screen/view/profile_view.dart';
import 'package:webapp/screen/viewModel/home_view_model.dart';

import '../../core/base/base_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: HomeViewModel(HomeService(NetworkManager())),
      onModelReady: (model) {
        model.init();
      },
      onPageBuilder: (context, viewModel, theme) => Row(
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Flexible(
                    flex: 6,
                    child:
                        SimpleContainer(title: "Profil", child: ProfileView())),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Flexible(
                    flex: 4,
                    child: buildGenderPieChart(
                        theme.colorScheme, theme, viewModel)),
                Flexible(
                    flex: 6,
                    child: SimpleContainer(
                        title: "Üzerime Zimmetli Ürünler",
                        child: ProductView())),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              children: [
                Flexible(
                    flex: 4,
                    child: buildDepartmentPieChart(
                        theme.colorScheme, theme, viewModel)),
                Flexible(
                    flex: 6,
                    child: SimpleContainer(
                      title: "Yaklaşan Doğum Günleri",
                      child: Observer(builder: (_) {
                        switch (viewModel.dataState) {
                          case DataState.READY:
                            return buildUpcomingBirthdayList(
                                viewModel, theme.colorScheme, theme);
                          case DataState.ERROR:
                            return const Center(
                                child: Text("Hata meydana geldi."));
                          case DataState.LOADING:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case DataState.EMPTY:
                            return const Center(
                                child:
                                    Text("Yaklaşan doğum günü bulunmamakta"));
                        }
                      }),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildUpcomingBirthdayList(
      HomeViewModel viewModel, ColorScheme colorScheme, ThemeData theme) {
    List<UpcomingBirthday> upcomingBirthdayList =
        viewModel.dashboard!.birthdays!;
    return Column(
      children: [
        Expanded(
          child: ListWidget(
              rowElementWidth: SizeConfig.blockSizeHorizontal * 6,
              titles: const [],
              data: [
                ...upcomingBirthdayList.map((e) => [
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          backgroundColor: colorScheme.primary,
                          child: Text(viewModel.getInitials(e.name!),
                              style: theme.textTheme.headlineSmall!
                                  .copyWith(color: colorScheme.background)),
                          radius: SizeConfig.blockSizeHorizontal * 3,
                        ),
                      ),
                      Text(e.name!),
                      Text(e.birthday!)
                    ])
              ]),
        )
      ],
    );
  }

  SimpleContainer buildGenderPieChart(
      ColorScheme colorScheme, ThemeData theme, HomeViewModel viewModel) {
    return SimpleContainer(
      title: "Cinsiyet Dağılımı",
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.READY:
            return buildReadyGenderPieChart(colorScheme, theme, viewModel);
          case DataState.ERROR:
            return const Center(child: Text("Hata meydana geldi."));
          case DataState.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case DataState.EMPTY:
            return buildReadyGenderPieChart(colorScheme, theme, viewModel);
        }
      }),
    );
  }

  SizedBox buildReadyGenderPieChart(
      ColorScheme colorScheme, ThemeData theme, HomeViewModel viewModel) {
    return SizedBox(
      child: SizedBox(
        height: SizeConfig.blockSizeVertical * 15,
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Observer(builder: (_) {
                return viewModel.dashboard!.genderPieChart!.femaleEmployeeNum !=
                            0 ||
                        viewModel.dashboard!.genderPieChart!.maleEmployeeNum !=
                            0
                    ? PieChart(
                        PieChartData(
                          centerSpaceRadius: SizeConfig.blockSizeVertical * 4,
                          sections: showingGenderSections(
                              colorScheme, theme, viewModel),
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              if (!event.isInterestedForInteractions ||
                                  pieTouchResponse == null ||
                                  pieTouchResponse.touchedSection == null) {
                                viewModel.pieChartIndex1 = -1;
                                return;
                              }
                              viewModel.changePieChartIndex1(pieTouchResponse
                                  .touchedSection!.touchedSectionIndex);
                            },
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 0,
                        width: 0,
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
                            viewModel.dashboard!.genderPieChart!.maleEmployeeNum
                                .toString(),
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
                            viewModel
                                .dashboard!.genderPieChart!.femaleEmployeeNum
                                .toString(),
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
    );
  }

  SimpleContainer buildDepartmentPieChart(
      ColorScheme colorScheme, ThemeData theme, HomeViewModel viewModel) {
    return SimpleContainer(
      title: "Departmanlar",
      child: Observer(builder: (_) {
        switch (viewModel.dataState) {
          case DataState.READY:
            return buildReadyDepartmentPieChart(colorScheme, theme, viewModel);
          case DataState.ERROR:
            return const Center(child: Text("Hata meydana geldi."));
          case DataState.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case DataState.EMPTY:
            return buildReadyDepartmentPieChart(colorScheme, theme, viewModel);
        }
      }),
    );
  }

  SizedBox buildReadyDepartmentPieChart(
      ColorScheme colorScheme, ThemeData theme, HomeViewModel viewModel) {
    List<DepartmentPieChart> departmentList =
        viewModel.dashboard!.departmentPieChart!;
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 15,
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Observer(builder: (_) {
              return PieChart(
                PieChartData(
                  centerSpaceRadius: SizeConfig.blockSizeVertical * 4,
                  sections:
                      showingDepartmentSections(colorScheme, theme, viewModel),
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        viewModel.pieChartIndex1 = -1;
                        return;
                      }
                      viewModel.changePieChartIndex2(
                          pieTouchResponse.touchedSection!.touchedSectionIndex);
                    },
                  ),
                ),
              );
            }),
          ),
          Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...departmentList.asMap().entries.map((e) => Indicator(
                            color: colorScheme.primary.withOpacity(
                                0.2 + 0.8 / departmentList.length * e.key),
                            text: e.value.departmentName!,
                            isSquare: true))
                      ],
                    ),
                    SizeConfig.horizontalSpace(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...departmentList.map(
                          (e) => Text(
                            e.employeeNum.toString(),
                            style: theme.textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    SizeConfig.horizontalSpace(),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingGenderSections(
      ColorScheme colorScheme, ThemeData theme, HomeViewModel viewModel) {
    return List.generate(2, (i) {
      final isTouched = viewModel.pieChartIndex1 == i;
      //final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 50.0 : 40.0;
      //const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: colorScheme.primary,
            value: viewModel.dashboard!.genderPieChart!.maleEmployeeNum!
                .toDouble(),
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: colorScheme.secondary,
            value: viewModel.dashboard!.genderPieChart!.femaleEmployeeNum!
                .toDouble(),
            radius: radius,
          );

        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingDepartmentSections(
      ColorScheme colorScheme, ThemeData theme, HomeViewModel viewModel) {
    List<DepartmentPieChart> departmentList =
        viewModel.dashboard!.departmentPieChart!;
    return List.generate(departmentList.length, (i) {
      final isTouched = viewModel.pieChartIndex2 == i;
      //final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 50.0 : 40.0;
      //const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return PieChartSectionData(
        showTitle: false,
        color: colorScheme.primary
            .withOpacity(0.2 + 0.8 / departmentList.length * i),
        value: departmentList[i].employeeNum!.toDouble(),
        radius: radius,
      );
    });
  }

  // Center buildOldScreen(ThemeData theme, ColorScheme colorScheme) {
  //   return Center(
  //     child: Padding(
  //       padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 2),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         children: [
  //           Expanded(
  //             flex: 3,
  //             child: SizedBox(
  //               height: SizeConfig.blockSizeVertical * 80,
  //               child: Padding(
  //                 padding: const EdgeInsets.all(8.0),
  //                 child: ShadowContainer(child: ProfileView()),
  //               ),
  //             ),
  //           ),
  //           Expanded(
  //             flex: 3,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 //buildBottomLeft(theme, colorScheme),
  //                 SizedBox(
  //                   height: SizeConfig.blockSizeVertical * 40,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: ShadowContainer(child: buildTopRight()),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: SizeConfig.blockSizeVertical * 40,
  //                   child: Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: ShadowContainer(
  //                         child: buildBottomRight(theme, colorScheme)),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ProductView buildBottomRight(ThemeData theme, ColorScheme colorScheme) =>
  //     ProductView();

  // NewTimeOffView buildTopRight() => NewTimeOffView();
  // TimeOffView buildTopLeft(ThemeData theme, ColorScheme colorScheme) =>
  //     TimeOffView();
}

//  Expanded(
//                 flex: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                       decoration: BoxDecoration(
//                         color: colorScheme.background,
//                         borderRadius: BorderRadius.circular(20),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             blurRadius: 2,
//                             offset: const Offset(
//                                 0, 5), // changes position of shadow
//                           ),
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.5),
//                             blurRadius: 2,
//                             offset: const Offset(
//                                 0, 0), // changes position of shadow
//                           ),
//                         ],
//                       ),
//                       height: SizeConfig.blockSizeVertical * 60,
//                       child: Padding(
//                         padding: const EdgeInsets.all(15.0),
//                         child: buildTopLeft(theme, colorScheme),
//                       )),
//                 ),
//               ),
