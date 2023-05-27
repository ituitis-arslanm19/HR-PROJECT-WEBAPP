import 'package:mobx/mobx.dart';
import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/service/home_service.dart';

import '../model/dashboard/dashboard.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase extends BaseViewModel with Store {
  final HomeService homeService;
  @observable
  int? pieChartIndex1 = -1;

  @observable
  int? pieChartIndex2 = -1;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  Dashboard? dashboard;

  _HomeViewModelBase(this.homeService);

  @action
  changePieChartIndex1(int value) {
    pieChartIndex1 = value;
  }

  @action
  changePieChartIndex2(int value) {
    pieChartIndex2 = value;
  }

  @override
  @action
  Future<void> init() async {
    ResponseModel<Dashboard?> result = await homeService.getDashBoardInfos();
    if ((!result.error!) && result.data != null) {
      dashboard = result.data;
      dashboard!.birthdays!.isEmpty
          ? dataState = DataState.EMPTY
          : DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }
}
