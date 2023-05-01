import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../../core/network/model/response_model.dart';
import '../model/qr_code.dart';

class QrCodeService {
  final NetworkManager networkManager;

  QrCodeService(this.networkManager);

  Future<QrCode?> getQrCode() async {
    ResponseModel<QrCode> result = await networkManager.send<QrCode, QrCode>(
        "/access", HttpMethod.GET, QrCode(), null, null);
    return result.data;
  }
}
