import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/shift.dart';
import '../service/shift_service.dart';
part 'shift_view_model.g.dart';

class ShiftViewModel = _ShiftViewModelBase with _$ShiftViewModel;

abstract class _ShiftViewModelBase with Store {
  final ShiftService shiftService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<Shift>? shiftList;

  @observable
  List<Shift>? shifts;

  _ShiftViewModelBase(this.shiftService);

  @action
  init() async {
    shifts = await shiftService.getShifts();
    shiftList = shifts;
    if (shiftList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name) {
    shiftList = shifts
        ?.where(
            (shift) => shift.name!.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }
}
