import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/drop_down_input_text.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/list_widget.dart';
import 'package:webapp/core/widgets/other/shadow_container.dart';
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
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: buildNewTimeOff(
                        theme, colorScheme, timeOffViewModel, context)),
                Expanded(
                    flex: 5,
                    child: SimpleContainer(
                      title: "Kalan İzinlerim",
                      child: Container(),
                    )),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              children: [
                Expanded(
                    flex: 5,
                    child: buildPendingTimeOffs(
                        theme, colorScheme, timeOffViewModel)),
                Expanded(
                    flex: 5,
                    child: buildPreviousTimeOffs(
                        theme, colorScheme, timeOffViewModel))
              ],
            ),
          ),
        ],
      ),
    );
  }

  SimpleContainer buildPendingTimeOffs(ThemeData theme, ColorScheme colorScheme,
      TimeOffViewModel timeOffViewModel) {
    return SimpleContainer(
      title: "Onay Bekleyen İzinlerim",
      child: Column(
        children: [
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
                return Center(
                    child: Text("Onay bekleyen izniniz bulunmamakta"));
            }
          })
        ],
      ),
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

  SimpleContainer buildPreviousTimeOffs(ThemeData theme,
      ColorScheme colorScheme, TimeOffViewModel timeOffViewModel) {
    return SimpleContainer(
      title: "İzin Geçmişim",
      child: Observer(builder: (_) {
        switch (timeOffViewModel.dataState2) {
          case DataState.READY:
            return buildPreviousList(timeOffViewModel, colorScheme, theme);

          case DataState.LOADING:
            return Center(
              child: CircularProgressIndicator(),
            );
          case DataState.ERROR:
            //return Center(child: Text("Hata meydana geldi"));
            return buildPreviousList(timeOffViewModel, colorScheme, theme);
          case DataState.EMPTY:
            //return Center(child: Text("Geçmiş izniniz bulunmamakta"));
            return buildPreviousList(timeOffViewModel, colorScheme, theme);
        }
      }),
    );
  }

  ListWidget buildPreviousList(TimeOffViewModel timeOffViewModel,
      ColorScheme colorScheme, ThemeData theme) {
    TextStyle textStyle =
        theme.textTheme.bodySmall!.copyWith(color: theme.hintColor);
    return ListWidget(
      data: [
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
        [
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "15/12/2000",
            style: textStyle,
          ),
          Text(
            "3",
            style: textStyle,
          ),
          Icon(Icons.check),
          Text(
            "Yıllık İzin",
            style: textStyle,
          )
        ],
      ],
      titles: [
        "Başlangıç Tarihi",
        "Bitiş Tarihi",
        "Gün Sayısı",
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
                return Center(
                  child: CircularProgressIndicator(),
                );
              case DataState.ERROR:
                return Center(child: Text("Hata meydana geldi"));
              case DataState.EMPTY:
                return Center(child: Text("İzin tipleri belirlenmeli"));
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
            Container(
              child: Form(
                key: timeOffViewModel.formKeyNewTimeOff,
                child: Column(
                  children: [
                    InputText(
                      icon: const Icon(Icons.calendar_month),
                      textEditingController: timeOffViewModel.controllers[0],
                      hintText: "Başlangıç tarihi",
                      enabled: true,
                      validator: timeOffViewModel.inputTextValidator,
                      onTap: () => _showCalendar(
                          context, timeOffViewModel.controllers[0]),
                    ),
                    InputText(
                      icon: const Icon(Icons.calendar_month),
                      textEditingController: timeOffViewModel.controllers[1],
                      hintText: "Bitiş Tarihi",
                      enabled: true,
                      validator: timeOffViewModel.inputTextValidator,
                      onTap: () => _showCalendar(
                          context, timeOffViewModel.controllers[1]),
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
