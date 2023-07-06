import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/time_off_type.dart';
import '../service/time_off_type_service.dart';
part 'time_off_type_view_model.g.dart';

class TimeOffTypeViewModel = _TimeOffTypeViewModelBase
    with _$TimeOffTypeViewModel;

abstract class _TimeOffTypeViewModelBase with Store {
  final TimeOffTypeService timeOffTypeService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<TimeOffType>? timeOffTypeList;

  @observable
  List<TimeOffType>? timeOffTypes;

  _TimeOffTypeViewModelBase(this.timeOffTypeService);

  @action
  init() async {
    timeOffTypes = await timeOffTypeService.getTimeOffTypes();
    timeOffTypeList = timeOffTypes;
    if (timeOffTypeList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name) {
    timeOffTypeList = timeOffTypes
        ?.where((timeOffType) =>
            timeOffType.name!.toLowerCase().startsWith(name.toLowerCase))
        .toList();
  }

  @action
  delete(int id) async {
    return await timeOffTypeService.delete(id);
  }
}
