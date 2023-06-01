// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_location_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AccessLocationViewModel on _AccessLocationViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_AccessLocationViewModelBase.dataState', context: context);

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

  late final _$accessLocationListAtom = Atom(
      name: '_AccessLocationViewModelBase.accessLocationList',
      context: context);

  @override
  List<AccessLocation>? get accessLocationList {
    _$accessLocationListAtom.reportRead();
    return super.accessLocationList;
  }

  @override
  set accessLocationList(List<AccessLocation>? value) {
    _$accessLocationListAtom.reportWrite(value, super.accessLocationList, () {
      super.accessLocationList = value;
    });
  }

  late final _$accessLocationsAtom = Atom(
      name: '_AccessLocationViewModelBase.accessLocations', context: context);

  @override
  List<AccessLocation>? get accessLocations {
    _$accessLocationsAtom.reportRead();
    return super.accessLocations;
  }

  @override
  set accessLocations(List<AccessLocation>? value) {
    _$accessLocationsAtom.reportWrite(value, super.accessLocations, () {
      super.accessLocations = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_AccessLocationViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$deleteAsyncAction =
      AsyncAction('_AccessLocationViewModelBase.delete', context: context);

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$_AccessLocationViewModelBaseActionController =
      ActionController(name: '_AccessLocationViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_AccessLocationViewModelBaseActionController
        .startAction(name: '_AccessLocationViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_AccessLocationViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
accessLocationList: ${accessLocationList},
accessLocations: ${accessLocations}
    ''';
  }
}
