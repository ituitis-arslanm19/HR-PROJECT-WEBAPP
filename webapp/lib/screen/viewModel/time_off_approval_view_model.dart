import 'package:flutter/material.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/model/approved_time_off.dart';
import 'package:webapp/screen/model/request/update_time_off_request.dart';
import 'package:webapp/screen/service/time_off_approval_service.dart';
import 'package:mobx/mobx.dart';

part 'time_off_approval_view_model.g.dart';

class TimeOffApprovalViewModel = _TimeOffApprovalViewModelBase
    with _$TimeOffApprovalViewModel;

abstract class _TimeOffApprovalViewModelBase extends BaseViewModel with Store {
  final TimeOffApprovalService timeOffApprovalService;
  final BuildContext buildContext;

  @observable
  DataState dataState1 = DataState.LOADING;

  @observable
  DataState dataState2 = DataState.LOADING;

  @observable
  String? description;

  @observable
  ObservableList<ApprovedTimeOff>? approvedTimeOffs;

  @observable
  ObservableList<ApprovedTimeOff>? pendingTimeOffs;

  _TimeOffApprovalViewModelBase(this.timeOffApprovalService, this.buildContext);

  @override
  void init() async {
    ResponseModel<Iterable<ApprovedTimeOff>?> result1 =
        await timeOffApprovalService.getPendingTimeOffs();

    if (!result1.error! && result1.data != null) {
      pendingTimeOffs = ObservableList.of(result1.data!);
      pendingTimeOffs!.isEmpty
          ? dataState1 = DataState.EMPTY
          : dataState1 = DataState.READY;
    } else {
      description = result1.description;
      dataState1 = DataState.ERROR;
    }

    ResponseModel<Iterable<ApprovedTimeOff>?> result2 =
        await timeOffApprovalService.getApprovedTimeOffs();
    if (!result2.error! && result2.data != null) {
      approvedTimeOffs = ObservableList.of(result2.data!);
      approvedTimeOffs!.isEmpty
          ? dataState2 = DataState.EMPTY
          : dataState2 = DataState.READY;
    } else {
      description = result2.description;
      dataState2 = DataState.ERROR;
    }
  }

  @action
  updateTimeOff(bool value, int id) async {
    ResponseModel<ApprovedTimeOff?> result =
        await timeOffApprovalService.updateTimeOff(UpdateTimeOffRequest(
            timeOffId: id, status: value ? "APPROVED" : "DENIED"));
    if (!result.error! && result.data != null) {
      init();
    }
    ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
        content: Text(
      result.description!,
      textAlign: TextAlign.center,
    )));
  }
}
