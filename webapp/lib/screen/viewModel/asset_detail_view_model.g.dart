// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetDetailViewModel on _AssetDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_AssetDetailViewModelBase.dataState', context: context);

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

  late final _$assetDetailAtom =
      Atom(name: '_AssetDetailViewModelBase.assetDetail', context: context);

  @override
  AssetDetail? get assetDetail {
    _$assetDetailAtom.reportRead();
    return super.assetDetail;
  }

  @override
  set assetDetail(AssetDetail? value) {
    _$assetDetailAtom.reportWrite(value, super.assetDetail, () {
      super.assetDetail = value;
    });
  }

  late final _$employeeListAtom =
      Atom(name: '_AssetDetailViewModelBase.employeeList', context: context);

  @override
  List<Employee>? get employeeList {
    _$employeeListAtom.reportRead();
    return super.employeeList;
  }

  @override
  set employeeList(List<Employee>? value) {
    _$employeeListAtom.reportWrite(value, super.employeeList, () {
      super.employeeList = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AssetDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateAssetAsyncAction =
      AsyncAction('_AssetDetailViewModelBase.updateAsset', context: context);

  @override
  Future updateAsset() {
    return _$updateAssetAsyncAction.run(() => super.updateAsset());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
assetDetail: ${assetDetail},
employeeList: ${employeeList}
    ''';
  }
}
