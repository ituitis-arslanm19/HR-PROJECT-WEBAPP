import 'package:flutter/material.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/screen/model/request/create_time_off_request.dart';
import 'package:webapp/screen/model/time_off.dart';
import 'package:webapp/screen/model/time_off_type.dart';
import 'package:mobx/mobx.dart';
import 'package:webapp/screen/service/new_time_off_service.dart';

import '../../core/network/model/response_model.dart';
part 'new_time_off_view_model.g.dart';

class NewTimeOffViewModel = _NewTimeOffViewModelBase with _$NewTimeOffViewModel;

abstract class _NewTimeOffViewModelBase extends BaseViewModel with Store {
  final NewTimeOffService newTimeOffService;

  final BuildContext buildContext;

  final formKeyNewTimeOff = GlobalKey<FormState>();

  _NewTimeOffViewModelBase(this.newTimeOffService, this.buildContext);

  @observable
  ObservableList<TimeOffType>? timeOffTypeList;

  late List<TextEditingController> controllers;

  @observable
  DataState dataState = DataState.LOADING;

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

    ResponseModel<Iterable<TimeOffType>?> result =
        await newTimeOffService.getTimeOffTypes();

    if (((!result.error!) || result.data != null)) {
      timeOffTypeList = ObservableList.of(result.data!);
      dataState = DataState.READY;
    } else {
      description = result.description;
      dataState = DataState.ERROR;
    }
  }

  void requestNewTimeOff() async {
    if (formKeyNewTimeOff.currentState!.validate()) {
      ResponseModel<TimeOff?> result =
          await newTimeOffService.requestNewTimeOff(CreateTimeOffRequest(
              startDate: controllers[0].text,
              endDate: controllers[1].text,
              timeOffTypeId: _getTimeOffTypeId(controllers[2].text)));
      if ((!result.error!) || result.data != null) {
        init();
      }
      ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
          content: Text(
        result.description!,
        textAlign: TextAlign.center,
      )));
    }
  }

  @action
  changeTimeOffTypeSelected() {
    timeOffTypeSelected = !timeOffTypeSelected;
  }

  int? _getTimeOffTypeId(String name) {
    for (TimeOffType timeOffType in timeOffTypeList!) {
      if (timeOffType.name == name) {
        return timeOffType.id!;
      }
    }
    return null;
  }

  String? inputTextValidator(String? value) {
    if (value != null) if (value.isEmpty) return '';
    return null;
  }
}
