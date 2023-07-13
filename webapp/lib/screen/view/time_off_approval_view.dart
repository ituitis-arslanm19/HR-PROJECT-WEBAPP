import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/data_grid.dart';
import 'package:webapp/core/widgets/other/simple_container.dart';
import 'package:webapp/core/widgets/other/time_off_approval_card.dart';
import 'package:webapp/screen/service/time_off_approval_service.dart';
import 'package:webapp/screen/viewModel/time_off_approval_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';

class TimeOffApprovalView extends StatelessWidget {
  TimeOffApprovalView({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    SizeConfig().init(context);
    TimeOffApprovalViewModel timeOffApprovalViewModel =
        TimeOffApprovalViewModel(
            TimeOffApprovalService(
              networkManager: NetworkManager(),
            ),
            context);
    timeOffApprovalViewModel.init();

    return buildPage(theme, colorScheme, timeOffApprovalViewModel, context);
  }

  Column buildPage(ThemeData theme, ColorScheme colorScheme,
      TimeOffApprovalViewModel timeOffApprovalViewModel, BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: buildPendingTimeOffs(
                theme, colorScheme, timeOffApprovalViewModel)),
        Expanded(
            child: buildApprovedTimeOffs(
                theme, colorScheme, timeOffApprovalViewModel, context))
      ],
    );
  }

  SimpleContainer buildPendingTimeOffs(ThemeData theme, ColorScheme colorScheme,
      TimeOffApprovalViewModel timeOffApprovalViewModel) {
    return SimpleContainer(
        title: "Onayımı Bekleyen İzinler",
        child: Observer(builder: (_) {
          switch (timeOffApprovalViewModel.dataState1) {
            case DataState.READY:
              return buildPendingList(timeOffApprovalViewModel);
            case DataState.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return const Center(child: Text(ERROR_MESSAGE));
            case DataState.EMPTY:
              return const Center(
                  child: Text("Onayınızı bekleyen izin bulunmamakta"));
          }
        }));
  }

  Align buildPendingList(TimeOffApprovalViewModel timeOffApprovalViewModel) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...timeOffApprovalViewModel.pendingTimeOffs!.map(
                (element) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 24,
                  width: SizeConfig.blockSizeVertical * 36,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TimeOffApprovalCard(
                      onTap: timeOffApprovalViewModel.updateTimeOff,
                      approvedTimeOff: element,
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }

  // ListView buildPendingTimeOffList2(List<ApprovedTimeOff> list,
  //     TimeOffApprovalViewModel timeOffApprovalViewModel) {
  //   return ListView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: list.length,
  //     itemBuilder: (context, index) {
  //       return TimeOffApprovalCard(
  //         onTap: timeOffApprovalViewModel.updateTimeOff,
  //         approvedTimeOff: list[index],
  //       );
  //     },
  //   );
  // }

  SimpleContainer buildApprovedTimeOffs(
      ThemeData theme,
      ColorScheme colorScheme,
      TimeOffApprovalViewModel timeOffApprovalViewModel,
      BuildContext context) {
    return SimpleContainer(
        title: "Departmanımda Alınan Diğer İzinler",
        child: Observer(builder: (_) {
          switch (timeOffApprovalViewModel.dataState2) {
            case DataState.READY:
              return buildApprovedList(
                  timeOffApprovalViewModel, theme, context);

            case DataState.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return const Center(child: Text(ERROR_MESSAGE));
            case DataState.EMPTY:
              return const Center(
                  child: Text("Departmanda alınan başka izin bulunmamakta"));
          }
        }));
  }

  DataGrid buildApprovedList(TimeOffApprovalViewModel timeOffApprovalViewModel,
      ThemeData theme, BuildContext context) {
    return DataGrid(
        dataSourceList: timeOffApprovalViewModel.approvedTimeOffs!,
        titles: const ["İzin Alan", "Başlangıç", "Bitiş", "İzin Türü"],
        columnNames: const ["name", "startDate", "endDate", "TimeOffType"]);
  }
}
