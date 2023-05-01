import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/drop_down_input_text.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/shadow_container.dart';
import 'package:webapp/screen/service/time_off_service.dart';
import 'package:webapp/screen/viewModel/time_off_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/time_off_card.dart';
import '../model/time_off.dart';

class TimeOffView extends StatelessWidget {
  // List of items in our dropdown menu
  TimeOffView({super.key});
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    SizeConfig().init(context);
    TimeOffViewModel timeOffViewModel = TimeOffViewModel(
        TimeOffService(networkManager: NetworkManager(SecureStorage())),
        context);
    timeOffViewModel.init();
    return buildPage(theme, colorScheme, timeOffViewModel, context);
  }

  Padding buildPage(ThemeData theme, ColorScheme colorScheme,
      TimeOffViewModel timeOffViewModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
      child: ShadowContainer(
        child: Column(
          children: [
            buildPendingTimeOffs(theme, colorScheme, timeOffViewModel),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 5,
            ),
            buildPreviousTimeOffs(theme, colorScheme, timeOffViewModel)
          ],
        ),
      ),
    );
  }

  Column buildPendingTimeOffs(ThemeData theme, ColorScheme colorScheme,
      TimeOffViewModel timeOffViewModel) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Onay Bekleyen İzinlerim",
            style: theme.textTheme.headlineMedium!
                .copyWith(color: colorScheme.primary),
            textAlign: TextAlign.start,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        Observer(builder: (_) {
          switch (timeOffViewModel.dataState1) {
            case DataState.READY:
              return buildPendingList(timeOffViewModel);

            case DataState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return Center(child: Text("Hata meydana geldi"));
            case DataState.EMPTY:
              return Center(child: Text("Onay bekleyen izniniz bulunmamakta"));
          }
        })
      ],
    );
  }

  Align buildPendingList(TimeOffViewModel timeOffViewModel) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...timeOffViewModel.pendingTimeOffList!.map(
                (element) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 24,
                  width: SizeConfig.blockSizeHorizontal * 36,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TimeOffCard(
                        startDate: element.startDate.toString(),
                        endDate: element.endDate.toString(),
                        status: TimeOffStatus.PENDING,
                        type: element.timeOffType!,
                        managerName: element.managersToSign![0]),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Column buildPreviousTimeOffs(ThemeData theme, ColorScheme colorScheme,
      TimeOffViewModel timeOffViewModel) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Geçmiş İzinlerim",
            style: theme.textTheme.headlineMedium!
                .copyWith(color: colorScheme.primary),
            textAlign: TextAlign.start,
          ),
        ),
        const Divider(
          thickness: 2,
        ),
        Observer(builder: (_) {
          switch (timeOffViewModel.dataState2) {
            case DataState.READY:
              return buildPreviousList(timeOffViewModel);

            case DataState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
            case DataState.ERROR:
              return Center(child: Text("Hata meydana geldi"));
            case DataState.EMPTY:
              return Center(child: Text("Geçmiş izniniz bulunmamakta"));
          }
        })
      ],
    );
  }

  Align buildPreviousList(TimeOffViewModel timeOffViewModel) {
    return Align(
      alignment: Alignment.topLeft,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...timeOffViewModel.previousTimeOffList!.map(
                (element) => SizedBox(
                  height: SizeConfig.blockSizeVertical * 24,
                  width: SizeConfig.blockSizeHorizontal * 36,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: TimeOffCard(
                        startDate: element.startDate.toString(),
                        endDate: element.endDate.toString(),
                        status: element.status!,
                        type: element.timeOffType!,
                        managerName: element.signHistories!.last.managerName! +
                            element.signHistories!.last.managerLastName!),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
