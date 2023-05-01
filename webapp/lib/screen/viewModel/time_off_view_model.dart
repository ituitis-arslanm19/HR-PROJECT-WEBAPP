import 'package:flutter/material.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/request/create_time_off_request.dart';
import 'package:webapp/screen/model/time_off.dart';
import 'package:webapp/screen/model/time_off_type.dart';
import 'package:mobx/mobx.dart';

import '../../core/network/model/response_model.dart';
import '../service/time_off_service.dart';
part 'time_off_view_model.g.dart';

class TimeOffViewModel = _TimeOffViewModelBase with _$TimeOffViewModel;

abstract class _TimeOffViewModelBase extends BaseViewModel with Store {
  final TimeOffService timeOffService;

  final BuildContext buildContext;

  final formKeyNewTimeOff = GlobalKey<FormState>();

  _TimeOffViewModelBase(this.timeOffService, this.buildContext);

  @observable
  ObservableList<TimeOff>? pendingTimeOffList;

  @observable
  ObservableList<TimeOff>? previousTimeOffList;

  late List<TextEditingController> controllers;

  @observable
  DataState dataState1 = DataState.LOADING;

  @observable
  DataState dataState2 = DataState.LOADING;

  @observable
  String? description;

  @observable
  DateTime selectedDate = DateTime.now();

  @observable
  bool timeOffTypeSelected = false;

  @action
  @override
  Future<void> init() async {
    controllers = List.generate(3, (i) => TextEditingController());

    ResponseModel<Iterable<TimeOff>?> result =
        await timeOffService.getTimeOffs();

    if (((!result.error!) || result.data != null)) {
      pendingTimeOffList = ObservableList();
      previousTimeOffList = ObservableList();
      for (TimeOff timeOff in result.data!) {
        timeOff.status == TimeOffStatus.PENDING
            ? pendingTimeOffList!.add(timeOff)
            : previousTimeOffList!.add(timeOff);
      }
      pendingTimeOffList!.isEmpty
          ? dataState1 = DataState.EMPTY
          : dataState1 = DataState.READY;

      previousTimeOffList!.isEmpty
          ? dataState2 = DataState.EMPTY
          : dataState2 = DataState.READY;
    } else {
      description = result.description;
      dataState1 = DataState.ERROR;
      dataState2 = DataState.ERROR;
    }
  }

  @action
  changeTimeOffTypeSelected() {
    timeOffTypeSelected = !timeOffTypeSelected;
  }

  String? inputTextValidator(String? value) {
    if (value != null) if (value.isEmpty) return 'Bu değer boş olamaz.';
    return null;
  }
}
