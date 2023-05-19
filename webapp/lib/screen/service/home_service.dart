import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/screen/model/dashboard/dashboard.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/network/model/response_model.dart';

class HomeService {
  final NetworkManager networkManager;

  HomeService(this.networkManager);

  Future<ResponseModel<Dashboard?>> getDashBoardInfos() async {
    ResponseModel<Dashboard> result =
        await networkManager.send<Dashboard, Dashboard>(
            "/dashboard", HttpMethod.GET, Dashboard(), null, null);

    return result;
  }
}
