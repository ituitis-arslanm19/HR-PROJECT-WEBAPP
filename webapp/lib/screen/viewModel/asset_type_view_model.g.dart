// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_type_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetTypeViewModel on _AssetTypeViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_AssetTypeViewModelBase.dataState', context: context);

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

  late final _$assetTypeListAtom =
      Atom(name: '_AssetTypeViewModelBase.assetTypeList', context: context);

  @override
  List<AssetType>? get assetTypeList {
    _$assetTypeListAtom.reportRead();
    return super.assetTypeList;
  }

  @override
  set assetTypeList(List<AssetType>? value) {
    _$assetTypeListAtom.reportWrite(value, super.assetTypeList, () {
      super.assetTypeList = value;
    });
  }

  late final _$assetTypesAtom =
      Atom(name: '_AssetTypeViewModelBase.assetTypes', context: context);

  @override
  List<AssetType>? get assetTypes {
    _$assetTypesAtom.reportRead();
    return super.assetTypes;
  }

  @override
  set assetTypes(List<AssetType>? value) {
    _$assetTypesAtom.reportWrite(value, super.assetTypes, () {
      super.assetTypes = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AssetTypeViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$deleteAsyncAction =
      AsyncAction('_AssetTypeViewModelBase.delete', context: context);

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$_AssetTypeViewModelBaseActionController =
      ActionController(name: '_AssetTypeViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_AssetTypeViewModelBaseActionController.startAction(
        name: '_AssetTypeViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_AssetTypeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
assetTypeList: ${assetTypeList},
assetTypes: ${assetTypes}
    ''';
  }
}
