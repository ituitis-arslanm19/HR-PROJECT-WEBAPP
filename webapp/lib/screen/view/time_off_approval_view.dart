import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/time_off_approval_card.dart';
import 'package:webapp/screen/service/time_off_approval_service.dart';
import 'package:webapp/screen/viewModel/time_off_approval_view_model.dart';
import 'package:webapp/screen/viewModel/time_off_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/shadow_container.dart';
import '../../core/widgets/other/time_off_card.dart';
import '../model/approved_time_off.dart';

class TimeOffApprovalView extends StatelessWidget {
  TimeOffApprovalView({super.key});
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    SizeConfig().init(context);
    TimeOffApprovalViewModel timeOffApprovalViewModel =
        TimeOffApprovalViewModel(
            TimeOffApprovalService(
              networkManager: NetworkManager(SecureStorage()),
            ),
            context);
    timeOffApprovalViewModel.init();

    return buildPage(theme, colorScheme, timeOffApprovalViewModel, context);
  }

  Padding buildPage(ThemeData theme, ColorScheme colorScheme,
      TimeOffApprovalViewModel timeOffApprovalViewModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
      child: ShadowContainer(
        child: Column(
          children: [
            buildPendingTimeOffs(theme, colorScheme, timeOffApprovalViewModel),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            buildApprovedTimeOffs(theme, colorScheme, timeOffApprovalViewModel)
          ],
        ),
      ),
    );
  }

  Column buildPendingTimeOffs(ThemeData theme, ColorScheme colorScheme,
      TimeOffApprovalViewModel timeOffApprovalViewModel) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Onayımı Bekleyen İzinler",
            style: theme.textTheme.headlineMedium!
                .copyWith(color: colorScheme.primary),
            textAlign: TextAlign.start,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        Observer(builder: (_) {
          switch (timeOffApprovalViewModel.dataState1) {
            case DataState.READY:
              return buildPendingList(timeOffApprovalViewModel);

            case DataState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return Center(child: Text("Hata meydana geldi"));
            case DataState.EMPTY:
              return Center(
                  child: Text("Onayınızı bekleyen izin bulunmamakta"));
          }
        })
      ],
    );
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
                  width: SizeConfig.blockSizeHorizontal * 36,
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

  Column buildApprovedTimeOffs(ThemeData theme, ColorScheme colorScheme,
      TimeOffApprovalViewModel timeOffApprovalViewModel) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Departmanda Alınan Diğer İzinler",
            style: theme.textTheme.headlineMedium!
                .copyWith(color: colorScheme.primary),
            textAlign: TextAlign.start,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        Observer(builder: (_) {
          switch (timeOffApprovalViewModel.dataState2) {
            case DataState.READY:
              return buildApprovedList(timeOffApprovalViewModel);

            case DataState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return Center(child: Text("Hata meydana geldi"));
            case DataState.EMPTY:
              return Center(
                  child: Text("Onayınızı bekleyen izin bulunmamakta"));
          }
        })
      ],
    );
  }

  Align buildApprovedList(TimeOffApprovalViewModel timeOffApprovalViewModel) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...timeOffApprovalViewModel.approvedTimeOffs!.map(
                (element) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 24,
                  width: SizeConfig.blockSizeHorizontal * 36,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TimeOffCard(
                      startDate: element.startDate ?? "",
                      endDate: element.endDate ?? "",
                      status: TimeOffStatus.APPROVED,
                      type: element.timeOffType ?? "",
                      name: (element.firstName ?? "") +
                          " " +
                          (element.lastName ?? ""),
                    ),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
