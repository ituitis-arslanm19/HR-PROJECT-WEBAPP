import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/data_grid.dart';
import 'package:webapp/core/widgets/other/drop_down_input_text.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/step_progress_indicator.dart';
import 'package:webapp/screen/service/time_off_service.dart';
import 'package:webapp/screen/viewModel/time_off_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/simple_container.dart';
import '../model/time_off.dart';

class TimeOffView extends StatelessWidget {
  const TimeOffView({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    SizeConfig().init(context);
    TimeOffViewModel timeOffViewModel = TimeOffViewModel(
        TimeOffService(networkManager: NetworkManager()), context);
    timeOffViewModel.init();
    return buildPage(theme, colorScheme, timeOffViewModel, context);
  }

  Padding buildPage(ThemeData theme, ColorScheme colorScheme,
      TimeOffViewModel timeOffViewModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 4),
      child: Column(
        children: [
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: buildNewTimeOff(
                        theme, colorScheme, timeOffViewModel, context)),
                Expanded(
                    flex: 6,
                    child: buildPendingTimeOffs(
                        context, theme, colorScheme, timeOffViewModel)),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              children: [
                Expanded(
                  child: buildPreviousTimeOffs(
                      theme, colorScheme, timeOffViewModel, context),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  SimpleContainer buildPendingTimeOffs(BuildContext context, ThemeData theme,
      ColorScheme colorScheme, TimeOffViewModel timeOffViewModel) {
    return SimpleContainer(
      title: "Onay Bekleyen İzinlerim",
      child: Observer(builder: (_) {
        switch (timeOffViewModel.dataState1) {
          case DataState.READY:
            return buildPendingList(
                context, timeOffViewModel, theme, colorScheme);

          case DataState.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case DataState.ERROR:
            return const Center(child: Text("Hata meydana geldi"));
          case DataState.EMPTY:
            return const Center(
                child: Text("Onay bekleyen izniniz bulunmamakta"));
        }
      }),
    );
  }

  DataGrid buildPendingList(
      BuildContext context,
      TimeOffViewModel timeOffViewModel,
      ThemeData theme,
      ColorScheme colorScheme) {
    List<TimeOff> pendingTimeOffList = timeOffViewModel.pendingTimeOffList!;

    return buildDataGrid(context, colorScheme, pendingTimeOffList, (date) {
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      final String formatted = formatter.format(date);
      TimeOff delete = pendingTimeOffList
          .firstWhere((element) => element.startDate == formatted);

      timeOffViewModel.deleteTimeOff(delete.id!);
    });
  }

  DataGrid buildDataGrid(BuildContext context, ColorScheme colorScheme,
      List<TimeOff> timeOffList, void Function(dynamic)? deleteFunction) {
    return DataGrid(
      deleteFunction: deleteFunction,
      onRowTap: (date) {
        final DateFormat formatter = DateFormat('dd/MM/yyyy');
        final String formatted = formatter.format(date);
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: colorScheme.background.withOpacity(0.8),
                child: StepProgressIndicator(
                  previousSteps: timeOffList
                      .firstWhere((element) => element.startDate == formatted)
                      .signHistories!,
                  futureSteps: timeOffList
                      .firstWhere((element) => element.startDate == formatted)
                      .managersToSign!,
                ),
              );
            });
      },
      dataSourceList: timeOffList,
      columnNames: const ["startDate", "endDate", "status", "type"],
      titles: const [
        "Başlangıç Tarihi",
        "Bitiş Tarihi",
        "Onay Durumu",
        "İzin tipi"
      ],
    );
  }

  SimpleContainer buildPreviousTimeOffs(
      ThemeData theme,
      ColorScheme colorScheme,
      TimeOffViewModel timeOffViewModel,
      BuildContext context) {
    return SimpleContainer(
      title: "İzin Geçmişim",
      child: Observer(builder: (_) {
        switch (timeOffViewModel.dataState2) {
          case DataState.READY:
            return buildPreviousList(
                timeOffViewModel, colorScheme, theme, context);

          case DataState.LOADING:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case DataState.ERROR:
            //return Center(child: Text("Hata meydana geldi"));
            return const Center(child: Text("Hata meydana geldi"));
          case DataState.EMPTY:
            //return Center(child: Text("Geçmiş izniniz bulunmamakta"));
            return const Center(child: Text("Geçmiş izniniz bulunmamakta"));
        }
      }),
    );
  }

  DataGrid buildPreviousList(TimeOffViewModel timeOffViewModel,
      ColorScheme colorScheme, ThemeData theme, BuildContext context) {
    List<TimeOff> previousTimeOffList = timeOffViewModel.previousTimeOffList!;

    return buildDataGrid(context, colorScheme, previousTimeOffList, null);
  }

  SimpleContainer buildNewTimeOff(ThemeData theme, ColorScheme colorScheme,
      TimeOffViewModel timeOffViewModel, BuildContext context) {
    return SimpleContainer(
        title: "Yeni İzin Talebi +",
        child: Observer(
          builder: (_) {
            switch (timeOffViewModel.dataStateTimeOffType) {
              case DataState.READY:
                return buildNewTimeOffForm(timeOffViewModel, context);

              case DataState.LOADING:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case DataState.ERROR:
                return const Center(child: Text("Hata meydana geldi"));
              case DataState.EMPTY:
                return const Center(child: Text("İzin tipleri belirlenmeli"));
            }
          },
        ));
  }

  Column buildNewTimeOffForm(
      TimeOffViewModel timeOffViewModel, BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: timeOffViewModel.formKeyNewTimeOff,
              child: Column(
                children: [
                  InputText(
                    icon: const Icon(Icons.calendar_month),
                    textEditingController: timeOffViewModel.controllers[0],
                    hintText: "Başlangıç tarihi",
                    enabled: true,
                    validator: timeOffViewModel.inputTextValidator,
                    onTap: () =>
                        _showCalendar(context, timeOffViewModel.controllers[0]),
                  ),
                  InputText(
                    icon: const Icon(Icons.calendar_month),
                    textEditingController: timeOffViewModel.controllers[1],
                    hintText: "Bitiş Tarihi",
                    enabled: true,
                    validator: timeOffViewModel.inputTextValidator,
                    onTap: () =>
                        _showCalendar(context, timeOffViewModel.controllers[1]),
                  ),
                  DropDownInputText(
                    textEditingController: timeOffViewModel.controllers[2],
                    hintText: "İzin Tipi",
                    validator: timeOffViewModel.inputTextValidator,
                    items: timeOffViewModel.timeOffTypeList!
                        .map((e) => e.name)
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 6.0,
                    ),
                    child: SizedBox(
                      height: SizeConfig.blockSizeVertical * 5,
                      child: Button(
                        onPressed: () {
                          timeOffViewModel.requestNewTimeOff();
                        },
                        text: "İZİN TALEBİ OLUŞTUR",
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  void _showCalendar(
      BuildContext context, TextEditingController textEditingController) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        locale: const Locale('tr'),
        initialDate: DateTime.now(),
        firstDate: DateTime(
            2000), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101),
        confirmText: "TAMAM");

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      textEditingController.text = formattedDate;
    }
  }
}
