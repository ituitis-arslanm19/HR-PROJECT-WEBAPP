// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SiteViewModel on _SiteViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_SiteViewModelBase.dataState', context: context);

  @override
  DataState get dataState {
    _$dataStateAtom.reportRead();
    return super.dataState;
  }

  @override
  set dataState(DataState value) {
    _$dataStateAtom.reportWrite(value, super.dataState, () {
      super.dataState = value;
    });
  }

  late final _$siteListAtom =
      Atom(name: '_SiteViewModelBase.siteList', context: context);

  @override
  List<Site>? get siteList {
    _$siteListAtom.reportRead();
    return super.siteList;
  }

  @override
  set siteList(List<Site>? value) {
    _$siteListAtom.reportWrite(value, super.siteList, () {
      super.siteList = value;
    });
  }

  late final _$sitesAtom =
      Atom(name: '_SiteViewModelBase.sites', context: context);

  @override
  List<Site>? get sites {
    _$sitesAtom.reportRead();
    return super.sites;
  }

  @override
  set sites(List<Site>? value) {
    _$sitesAtom.reportWrite(value, super.sites, () {
      super.sites = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_SiteViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$deleteAsyncAction =
      AsyncAction('_SiteViewModelBase.delete', context: context);

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$_SiteViewModelBaseActionController =
      ActionController(name: '_SiteViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_SiteViewModelBaseActionController.startAction(
        name: '_SiteViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_SiteViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
siteList: ${siteList},
sites: ${sites}
    ''';
  }
}
