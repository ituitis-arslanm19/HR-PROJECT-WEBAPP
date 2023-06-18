import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/profile_card.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/screen/service/department_info_service.dart';
import 'package:webapp/screen/viewModel/department_detail_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/constant/strings.dart';
import '../../core/widgets/other/indicator.dart';
import '../model/employee.dart';
import '../viewModel/department_info_view_model.dart';

class DepartmentInfoView extends StatelessWidget {
  final int id;
  const DepartmentInfoView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    DepartmentInfoViewModel departmentInfoViewModel =
        DepartmentInfoViewModel(DepartmentInfoService(NetworkManager()), id);
    departmentInfoViewModel.init();
    return Scaffold(body: Observer(builder: (_) {
      switch (departmentInfoViewModel.dataState) {
        case DataState.READY:
          return buildPage(departmentInfoViewModel, theme, colorScheme);
        case DataState.LOADING:
          return const Center(
            child: CircularProgressIndicator(),
          );
        default:
          return const Center(child: Text(ERROR_MESSAGE));
      }
    }));
  }

  Column buildPage(DepartmentInfoViewModel departmentInfoViewModel,
      ThemeData theme, ColorScheme colorScheme) {
    return Column(
      children: [
        buildTitle(departmentInfoViewModel, theme, colorScheme),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      buildDepartmentInfos(departmentInfoViewModel),
                      buildManagerInfos(departmentInfoViewModel),
                    ],
                  )),
              Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      buildEmployeeList(
                          colorScheme, theme, departmentInfoViewModel),
                      Expanded(
                        flex: 5,
                        child: Center(
                            child: buildGenderPieChart(
                                colorScheme, theme, departmentInfoViewModel)),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildEmployeeList(ColorScheme colorScheme, ThemeData theme,
      DepartmentInfoViewModel departmentInfoViewModel) {
    List<Employee> employeeList =
        departmentInfoViewModel.departmentInfo!.employeeList!;
    return Expanded(
      flex: 5,
      child: SimpleContainer(
          title: "Çalışan Listesi",
          child: Column(
            children: [
              Expanded(
                  child: employeeList.isNotEmpty
                      ? ListWidget(
                          rowElementWidth: SizeConfig.blockSizeHorizontal * 6,
                          titles: const [],
                          data: employeeList
                              .map(
                                (e) => [
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: CircleAvatar(
                                      backgroundColor: colorScheme.primary,
                                      radius:
                                          SizeConfig.blockSizeHorizontal * 3,
                                      child: Text(
                                          departmentInfoViewModel.getInitials(
                                              (e.firstName ?? "") +
                                                  (e.lastName ?? "Hata")),
                                          style: theme.textTheme.headlineSmall!
                                              .copyWith(
                                                  color:
                                                      colorScheme.background)),
                                    ),
                                  ),
                                  Text((e.firstName ?? "Hata") +
                                      " " +
                                      (e.lastName ?? "")),
                                  Text(e.email ?? "Hata")
                                ],
                              )
                              .toList())
                      : const Center(
                          child: Text("Departmanda çalışan bulunmamakta"),
                        )),
            ],
          )),
    );
  }

  Expanded buildManagerInfos(
      DepartmentInfoViewModel departmentDetailViewModel) {
    return Expanded(
      flex: 5,
      child: SimpleContainer(
          title: "Yönetici Bilgileri",
          child: Column(
            children: [
              ProfileCard(
                title: "İsim",
                value: departmentDetailViewModel.departmentInfo!.managerName,
              ),
              ProfileCard(
                title: "E-posta",
                value: departmentDetailViewModel.departmentInfo!.managerEmail,
              ),
              ProfileCard(
                title: "Çalışma Saatleri",
                value: departmentDetailViewModel.departmentInfo!.managerShift,
              )
            ],
          )),
    );
  }

  Expanded buildDepartmentInfos(
      DepartmentInfoViewModel departmentDetailViewModel) {
    return Expanded(
      flex: 5,
      child: SimpleContainer(
          title: "Departman Bilgileri",
          child: Column(
            children: [
              ProfileCard(
                title: "İsim",
                value: departmentDetailViewModel.departmentInfo!.name,
              ),
              ProfileCard(
                title: "Çalışan Sayısı",
                value: departmentDetailViewModel.departmentInfo!.employeeNum
                    .toString(),
              ),
              ProfileCard(
                  title: "Üst Departman",
                  value: departmentDetailViewModel
                              .departmentInfo!.parentDepartmentName ==
                          ""
                      ? "Yok"
                      : departmentDetailViewModel
                          .departmentInfo!.parentDepartmentName),
            ],
          )),
    );
  }

  Padding buildTitle(DepartmentInfoViewModel departmentDetailViewModel,
      ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            departmentDetailViewModel.departmentInfo!.name!,
            style: theme.textTheme.headlineLarge!
                .copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }

  SimpleContainer buildGenderPieChart(ColorScheme colorScheme, ThemeData theme,
      DepartmentInfoViewModel departmentInfoViewModel) {
    return SimpleContainer(
      title: "Çalışan Dağılımı",
      child: SizedBox(
        child: SizedBox(
            height: SizeConfig.blockSizeVertical * 15,
            child: departmentInfoViewModel.departmentInfo!.genderPieChart!
                            .femaleEmployeeNum !=
                        0 ||
                    departmentInfoViewModel
                            .departmentInfo!.genderPieChart!.maleEmployeeNum !=
                        0
                ? Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Observer(builder: (_) {
                          return PieChart(
                            PieChartData(
                              centerSpaceRadius:
                                  SizeConfig.blockSizeVertical * 5,
                              sections: showingGenderSections(
                                  colorScheme, theme, departmentInfoViewModel),
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    departmentInfoViewModel.pieChartIndex = -1;
                                    return;
                                  }
                                  departmentInfoViewModel.changePieChartIndex(
                                      pieTouchResponse
                                          .touchedSection!.touchedSectionIndex);
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
                                      departmentInfoViewModel.departmentInfo!
                                          .genderPieChart!.maleEmployeeNum
                                          .toString(),
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height: SizeConfig.blockSizeVertical * 1),
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
                                      departmentInfoViewModel.departmentInfo!
                                          .genderPieChart!.femaleEmployeeNum
                                          .toString(),
                                      style: theme.textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ))
                    ],
                  )
                : const Center(
                    child: Text("Departmanda çalışan bulunmamakta"),
                  )),
      ),
    );
  }

  List<PieChartSectionData> showingGenderSections(ColorScheme colorScheme,
      ThemeData theme, DepartmentInfoViewModel departmentInfoViewModel) {
    return List.generate(2, (i) {
      final isTouched = departmentInfoViewModel.pieChartIndex == i;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 50.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            showTitle: false,
            color: colorScheme.primary,
            value: departmentInfoViewModel
                .departmentInfo!.genderPieChart!.maleEmployeeNum!
                .toDouble(),
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            showTitle: false,
            color: colorScheme.secondary,
            value: departmentInfoViewModel
                .departmentInfo!.genderPieChart!.femaleEmployeeNum!
                .toDouble(),
            radius: radius,
          );

        default:
          throw Error();
      }
    });
  }
}
