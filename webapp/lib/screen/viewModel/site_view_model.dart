import 'package:mobx/mobx.dart';

import '../../core/constant/enum/enums.dart';
import '../model/site.dart';
import '../service/site_service.dart';
part 'site_view_model.g.dart';

class SiteViewModel = _SiteViewModelBase with _$SiteViewModel;

abstract class _SiteViewModelBase with Store {
  final SiteService siteService;

  @observable
  DataState dataState = DataState.LOADING;

  @observable
  List<Site>? siteList;

  @observable
  List<Site>? sites;

  _SiteViewModelBase(this.siteService);

  @action
  init() async {
    sites = await siteService.getSites();
    siteList = sites;
    if (siteList != null) {
      dataState = DataState.READY;
    } else {
      dataState = DataState.ERROR;
    }
  }

  @action
  filter(name) {
    siteList = sites
        ?.where(
            (sites) => sites.name!.toLowerCase().startsWith(name.toLowerCase()))
        .toList();
  }

  @action
  delete(int id) async {
    return await siteService.delete(id);
  }
}
