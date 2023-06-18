import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/drop_down_input_text.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/screen/service/time_off_service.dart';
import 'package:webapp/screen/viewModel/time_off_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/simple_container.dart';
import '../../core/widgets/other/time_off_card.dart';
import '../model/time_off.dart';

class TimeOffView extends StatelessWidget {
  // List of items in our dropdown menu
  TimeOffView({super.key});
  final ScrollController _scrollController = ScrollController();

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

  Align buildPendingList(
      BuildContext context,
      TimeOffViewModel timeOffViewModel,
      ThemeData theme,
      ColorScheme colorScheme) {
    return Align(
      alignment: Alignment.topLeft,
      child: Scrollbar(
        thumbVisibility: true,
        thickness: 10,
        radius: Radius.circular(20), //corner radius of scrollbar
        scrollbarOrientation: ScrollbarOrientation.bottom,
        controller: _scrollController,

        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: _scrollController,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...timeOffViewModel.pendingTimeOffList!.map(
                  (element) => SizedBox(
                    height: SizeConfig.blockSizeVertical * 24,
                    width: SizeConfig.blockSizeVertical * 36,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TimeOffCard(
                          deleteEnable: true,
                          onPressed: () {
                            showDeletePopup(
                                context, timeOffViewModel, theme, colorScheme);
                          },
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
      ),
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

  ListWidget buildPreviousList(TimeOffViewModel timeOffViewModel,
      ColorScheme colorScheme, ThemeData theme, BuildContext context) {
    List<TimeOff> previousTimeOffList = timeOffViewModel.previousTimeOffList!;
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    return ListWidget(
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
                    startDate: previousTimeOffList[index].startDate,
                    endDate: previousTimeOffList[index].endDate,
                    status: previousTimeOffList[index].status,
                    type: previousTimeOffList[index].timeOffType,
                    managerName: (previousTimeOffList[index]
                                .signHistories!
                                .last
                                .managerName ??
                            "Hata") +
                        (previousTimeOffList[index]
                                .signHistories!
                                .last
                                .managerLastName ??
                            "Hata"),
                  ),
                ),
              );
            });
      },
      data: previousTimeOffList
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
    );
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
                    selected: timeOffViewModel.timeOffTypeSelected,
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

  void showDeletePopup(BuildContext context, TimeOffViewModel timeOffViewModel,
      ThemeData theme, ColorScheme colorScheme) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Container(
          height: SizeConfig.blockSizeVertical * 15,
          width: SizeConfig.blockSizeVertical * 40,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "İzin talebinizi iptal etmek istediğinize emin misiniz?",
                  style: theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => timeOffViewModel.deleteTimeOff(),
                    child: Text(
                      "EVET",
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "HAYIR",
                      style: theme.textTheme.bodyMedium!.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
