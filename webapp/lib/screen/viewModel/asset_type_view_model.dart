import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/asset_type.dart';
import '../service/asset_type_service.dart';
part 'asset_type_view_model.g.dart';


class AssetTypeViewModel = _AssetTypeViewModelBase
    with _$AssetTypeViewModel;

abstract class _AssetTypeViewModelBase with Store {
  final AssetTypeService assetTypeService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<AssetType>? assetTypeList;

  @observable
  List<AssetType>? assetTypes;

  _AssetTypeViewModelBase(this.assetTypeService);

  @action
  init() async {
    assetTypes = await assetTypeService.getAssetTypes();
    assetTypeList = assetTypes;
    if (assetTypeList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name) {
    assetTypeList = assetTypes
        ?.where((assetType) =>
            assetType.name!.toString().toLowerCase().startsWith(name.toLowerCase))
        .toList();
  }

  @action
  delete(int id) async {
    return await assetTypeService.delete(id);
  }
}
