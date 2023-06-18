import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/util/size_config.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/profile_card.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/core/widgets/other/time_off_card.dart';
import 'package:webapp/screen/service/employee_info_service.dart';
import 'package:webapp/screen/viewModel/employee_info_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../model/employee_info.dart';
import '../model/time_off.dart';

class EmployeeInfoView extends StatelessWidget {
  final int id;
  const EmployeeInfoView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    EmployeeInfoViewModel employeeInfoViewModel =
        EmployeeInfoViewModel(EmployeeInfoService(NetworkManager()), id);
    employeeInfoViewModel.init();
    return Scaffold(body: Observer(builder: (_) {
      switch (employeeInfoViewModel.dataState) {
        case DataState.READY:
          return buildPage(
              employeeInfoViewModel, theme, colorScheme, textStyle, context);
        case DataState.LOADING:
          return const Center(
            child: CircularProgressIndicator(),
          );
        default:
          return const Center(child: Text(ERROR_MESSAGE));
      }
    }));
  }

  Column buildPage(EmployeeInfoViewModel employeeInfoViewModel, ThemeData theme,
      ColorScheme colorScheme, TextStyle textStyle, BuildContext context) {
    return Column(
      children: [
        buildTitle(employeeInfoViewModel, theme, colorScheme),
        Expanded(
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      buildPersonalInfos(employeeInfoViewModel.employeeInfo!),
                      buildOtherInfos(employeeInfoViewModel.employeeInfo!),
                    ],
                  )),
              Expanded(
                  flex: 6,
                  child: Column(
                    children: [
                      buildPreviousTimeOffs(
                          textStyle,
                          employeeInfoViewModel.employeeInfo!.previousTimeOffs!,
                          context),
                      buildPendingTimeOffs(
                          textStyle,
                          employeeInfoViewModel.employeeInfo!.waitingTimeOffs!,
                          context)
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Expanded buildPendingTimeOffs(TextStyle textStyle,
      List<TimeOff> pendingTimeOffs, BuildContext context) {
    return Expanded(
        flex: 5,
        child: SimpleContainer(
          title: "Onay Bekleyen İzinler",
          child: pendingTimeOffs.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListWidget(
                        onTap: (index) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: SizedBox(
                                    height: SizeConfig.blockSizeVertical * 24,
                                    width: SizeConfig.blockSizeVertical * 36,
                                    child: TimeOffCard(
                                      startDate:
                                          pendingTimeOffs[index].startDate!,
                                      endDate: pendingTimeOffs[index].endDate!,
                                      status: pendingTimeOffs[index].status!,
                                      type: pendingTimeOffs[index].timeOffType!,
                                      managerName: pendingTimeOffs[index]
                                          .managersToSign![0],
                                    ),
                                  ),
                                );
                              });
                        },
                        data: pendingTimeOffs
                            .map((e) => [
                                  Text(
                                    e.startDate ?? "Hata",
                                    style: textStyle,
                                  ),
                                  Text(
                                    e.endDate ?? "Hata",
                                    style: textStyle,
                                  ),
                                  Text(
                                    e.timeOffType ?? "Hata",
                                    style: textStyle,
                                  )
                                ])
                            .toList(),
                        titles: const [
                          "Başlangıç Tarihi",
                          "Bitiş Tarihi",
                          "İzin tipi"
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text("Onay bekleyen izin bulunmamakta"),
                ),
        ));
  }

  Expanded buildPreviousTimeOffs(TextStyle textStyle,
      List<TimeOff> previousTimeOffs, BuildContext context) {
    return Expanded(
        flex: 5,
        child: SimpleContainer(
          title: "Geçmiş İzinler",
          child: previousTimeOffs.isNotEmpty
              ? Column(
                  children: [
                    Expanded(
                      child: ListWidget(
                        onTap: (index) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: SizedBox(
                                    height: SizeConfig.blockSizeVertical * 24,
                                    width: SizeConfig.blockSizeVertical * 36,
                                    child: TimeOffCard(
                                      startDate:
                                          previousTimeOffs[index].startDate!,
                                      endDate: previousTimeOffs[index].endDate!,
                                      status: previousTimeOffs[index].status!,
                                      type:
                                          previousTimeOffs[index].timeOffType!,
                                      managerName: previousTimeOffs[index]
                                              .signHistories!
                                              .last
                                              .managerName! +
                                          previousTimeOffs[index]
                                              .signHistories!
                                              .last
                                              .managerLastName!,
                                    ),
                                  ),
                                );
                              });
                        },
                        data: previousTimeOffs
                            .map((e) => [
                                  Text(
                                    e.startDate ?? "Hata",
                                    style: textStyle,
                                  ),
                                  Text(
                                    e.endDate ?? "Hata",
                                    style: textStyle,
                                  ),
                                  Icon(
                                    e.status == TimeOffStatus.APPROVED
                                        ? Icons.check
                                        : Icons.close,
                                    color: e.status == TimeOffStatus.APPROVED
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  Text(
                                    e.timeOffType ?? "Hata",
                                    style: textStyle,
                                  )
                                ])
                            .toList(),
                        titles: const [
                          "Başlangıç Tarihi",
                          "Bitiş Tarihi",
                          "Onay Durumu",
                          "İzin tipi"
                        ],
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text("Geçmiş izin bulunmamakta"),
                ),
        ));
  }

  Expanded buildOtherInfos(EmployeeInfo employeeInfo) {
    return Expanded(
      child: SimpleContainer(
          title: "Diğer Bilgiler",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileCard(
                tittle: "Departman",
                value: employeeInfo.departmentName,
              ),
              ProfileCard(
                tittle: "Başlangıç Tarihi",
                value: employeeInfo.startDate,
              ),
              ProfileCard(
                tittle: "Kalan Yıllık İzin",
                value: employeeInfo.remainingTimeOffDays.toString(),
              ),
            ],
          )),
    );
  }

  Expanded buildPersonalInfos(EmployeeInfo employeeInfo) {
    return Expanded(
      child: SimpleContainer(
          title: "Kişisel Bilgiler",
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ProfileCard(
                tittle: "İsim",
                value: (employeeInfo.firstName ?? "Hata") +
                    " " +
                    (employeeInfo.lastName ?? ""),
              ),
              ProfileCard(
                tittle: "E-posta",
                value: employeeInfo.email,
              ),
              ProfileCard(
                tittle: "Doğum Tarihi",
                value: employeeInfo.startDate,
              ),
            ],
          )),
    );
  }

  Padding buildTitle(EmployeeInfoViewModel employeeInfoViewModel,
      ThemeData theme, ColorScheme colorScheme) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            (employeeInfoViewModel.employeeInfo!.firstName ?? "Hata") +
                " " +
                (employeeInfoViewModel.employeeInfo!.lastName ?? ""),
            style: theme.textTheme.headlineLarge!
                .copyWith(color: colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Container buildCircularImage(
      ColorScheme colorScheme, ThemeData theme, String nameInitials) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: colorScheme.primary, width: 3)),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade400,
        radius: SizeConfig.blockSizeHorizontal * 5,
        child: Text(nameInitials.toUpperCase(),
            style: theme.textTheme.headlineLarge!
                .copyWith(color: colorScheme.background)),
      ),
    );
  }
}
