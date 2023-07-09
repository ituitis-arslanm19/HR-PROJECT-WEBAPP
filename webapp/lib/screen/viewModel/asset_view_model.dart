import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/asset.dart';
import '../service/asset_service.dart';
part 'asset_view_model.g.dart';

class AssetViewModel = _AssetViewModelBase with _$AssetViewModel;

abstract class _AssetViewModelBase with Store {
  final AssetService assetService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<Asset>? assetList;

  @observable
  List<Asset>? assets;

  _AssetViewModelBase(this.assetService);

  @action
  init() async {
    assets = await assetService.getAssets();
    assetList = assets;
    if (assetList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name) {
    assetList = assets
        ?.where(
            (asset) => asset.name!.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }

  @action
  delete(int id) async {
    return await assetService.delete(id);
  }
}
