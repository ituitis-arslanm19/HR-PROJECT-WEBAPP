// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SiteDetailViewModel on _SiteDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_SiteDetailViewModelBase.dataState', context: context);

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

  late final _$siteDetailAtom =
      Atom(name: '_SiteDetailViewModelBase.siteDetail', context: context);

  @override
  Site? get siteDetail {
    _$siteDetailAtom.reportRead();
    return super.siteDetail;
  }

  @override
  set siteDetail(Site? value) {
    _$siteDetailAtom.reportWrite(value, super.siteDetail, () {
      super.siteDetail = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_SiteDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateSiteAsyncAction =
      AsyncAction('_SiteDetailViewModelBase.updateSite', context: context);

  @override
  Future updateSite() {
    return _$updateSiteAsyncAction.run(() => super.updateSite());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
siteDetail: ${siteDetail}
    ''';
  }
}
