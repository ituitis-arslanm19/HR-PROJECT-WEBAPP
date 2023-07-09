// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetViewModel on _AssetViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_AssetViewModelBase.dataState', context: context);

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

  late final _$assetListAtom =
      Atom(name: '_AssetViewModelBase.assetList', context: context);

  @override
  List<Asset>? get assetList {
    _$assetListAtom.reportRead();
    return super.assetList;
  }

  @override
  set assetList(List<Asset>? value) {
    _$assetListAtom.reportWrite(value, super.assetList, () {
      super.assetList = value;
    });
  }

  late final _$assetsAtom =
      Atom(name: '_AssetViewModelBase.assets', context: context);

  @override
  List<Asset>? get assets {
    _$assetsAtom.reportRead();
    return super.assets;
  }

  @override
  set assets(List<Asset>? value) {
    _$assetsAtom.reportWrite(value, super.assets, () {
      super.assets = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AssetViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$deleteAsyncAction =
      AsyncAction('_AssetViewModelBase.delete', context: context);

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$_AssetViewModelBaseActionController =
      ActionController(name: '_AssetViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_AssetViewModelBaseActionController.startAction(
        name: '_AssetViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_AssetViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
assetList: ${assetList},
assets: ${assets}
    ''';
  }
}
