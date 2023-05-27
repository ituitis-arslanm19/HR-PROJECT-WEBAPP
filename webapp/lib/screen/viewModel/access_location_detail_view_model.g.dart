// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_location_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccessLocationDetailViewModel
    on _AccessLocationDetailViewModelBase, Store {
  late final _$dataStateAtom = Atom(
      name: '_AccessLocationDetailViewModelBase.dataState', context: context);

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

  late final _$siteListAtom = Atom(
      name: '_AccessLocationDetailViewModelBase.siteList', context: context);

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

  late final _$accessLocationDetailAtom = Atom(
      name: '_AccessLocationDetailViewModelBase.accessLocationDetail',
      context: context);

  @override
  AccessLocationDetail? get accessLocationDetail {
    _$accessLocationDetailAtom.reportRead();
    return super.accessLocationDetail;
  }

  @override
  set accessLocationDetail(AccessLocationDetail? value) {
    _$accessLocationDetailAtom.reportWrite(value, super.accessLocationDetail,
        () {
      super.accessLocationDetail = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AccessLocationDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateAccessLocationAsyncAction = AsyncAction(
      '_AccessLocationDetailViewModelBase.updateAccessLocation',
      context: context);

  @override
  Future updateAccessLocation() {
    return _$updateAccessLocationAsyncAction
        .run(() => super.updateAccessLocation());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
siteList: ${siteList},
accessLocationDetail: ${accessLocationDetail}
    ''';
  }
}
