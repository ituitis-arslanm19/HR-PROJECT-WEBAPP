// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeViewModel on _HomeViewModelBase, Store {
  late final _$pieChartIndex1Atom =
      Atom(name: '_HomeViewModelBase.pieChartIndex1', context: context);

  @override
  int? get pieChartIndex1 {
    _$pieChartIndex1Atom.reportRead();
    return super.pieChartIndex1;
  }

  @override
  set pieChartIndex1(int? value) {
    _$pieChartIndex1Atom.reportWrite(value, super.pieChartIndex1, () {
      super.pieChartIndex1 = value;
    });
  }

  late final _$pieChartIndex2Atom =
      Atom(name: '_HomeViewModelBase.pieChartIndex2', context: context);

  @override
  int? get pieChartIndex2 {
    _$pieChartIndex2Atom.reportRead();
    return super.pieChartIndex2;
  }

  @override
  set pieChartIndex2(int? value) {
    _$pieChartIndex2Atom.reportWrite(value, super.pieChartIndex2, () {
      super.pieChartIndex2 = value;
    });
  }

  late final _$dataStateAtom =
      Atom(name: '_HomeViewModelBase.dataState', context: context);

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

  late final _$dashboardAtom =
      Atom(name: '_HomeViewModelBase.dashboard', context: context);

  @override
  Dashboard? get dashboard {
    _$dashboardAtom.reportRead();
    return super.dashboard;
  }

  @override
  set dashboard(Dashboard? value) {
    _$dashboardAtom.reportWrite(value, super.dashboard, () {
      super.dashboard = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_HomeViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$_HomeViewModelBaseActionController =
      ActionController(name: '_HomeViewModelBase', context: context);

  @override
  dynamic changePieChartIndex1(int value) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changePieChartIndex1');
    try {
      return super.changePieChartIndex1(value);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePieChartIndex2(int value) {
    final _$actionInfo = _$_HomeViewModelBaseActionController.startAction(
        name: '_HomeViewModelBase.changePieChartIndex2');
    try {
      return super.changePieChartIndex2(value);
    } finally {
      _$_HomeViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pieChartIndex1: ${pieChartIndex1},
pieChartIndex2: ${pieChartIndex2},
dataState: ${dataState},
dashboard: ${dashboard}
    ''';
  }
}
