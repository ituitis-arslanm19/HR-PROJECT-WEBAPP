// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_type_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetTypeDetailViewModel on _AssetTypeDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_AssetTypeDetailViewModelBase.dataState', context: context);

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

  late final _$assetTypeAtom =
      Atom(name: '_AssetTypeDetailViewModelBase.assetType', context: context);

  @override
  AssetType? get assetType {
    _$assetTypeAtom.reportRead();
    return super.assetType;
  }

  @override
  set assetType(AssetType? value) {
    _$assetTypeAtom.reportWrite(value, super.assetType, () {
      super.assetType = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AssetTypeDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateAssetTypeAsyncAction = AsyncAction(
      '_AssetTypeDetailViewModelBase.updateAssetType',
      context: context);

  @override
  Future<bool> updateAssetType() {
    return _$updateAssetTypeAsyncAction.run(() => super.updateAssetType());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
assetType: ${assetType}
    ''';
  }
}
