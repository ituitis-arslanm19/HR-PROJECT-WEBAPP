// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MainViewModel on _MainViewModelBase, Store {
  late final _$isLoadingAtom =
      Atom(name: '_MainViewModelBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$bnbIndexAtom =
      Atom(name: '_MainViewModelBase.bnbIndex', context: context);

  @override
  int get bnbIndex {
    _$bnbIndexAtom.reportRead();
    return super.bnbIndex;
  }

  @override
  set bnbIndex(int value) {
    _$bnbIndexAtom.reportWrite(value, super.bnbIndex, () {
      super.bnbIndex = value;
    });
  }

  late final _$managerSubMenuAtom =
      Atom(name: '_MainViewModelBase.managerSubMenu', context: context);

  @override
  bool get managerSubMenu {
    _$managerSubMenuAtom.reportRead();
    return super.managerSubMenu;
  }

  @override
  set managerSubMenu(bool value) {
    _$managerSubMenuAtom.reportWrite(value, super.managerSubMenu, () {
      super.managerSubMenu = value;
    });
  }

  late final _$hrSubMenuAtom =
      Atom(name: '_MainViewModelBase.hrSubMenu', context: context);

  @override
  bool get hrSubMenu {
    _$hrSubMenuAtom.reportRead();
    return super.hrSubMenu;
  }

  @override
  set hrSubMenu(bool value) {
    _$hrSubMenuAtom.reportWrite(value, super.hrSubMenu, () {
      super.hrSubMenu = value;
    });
  }

  late final _$adminSubMenuAtom =
      Atom(name: '_MainViewModelBase.adminSubMenu', context: context);

  @override
  bool get adminSubMenu {
    _$adminSubMenuAtom.reportRead();
    return super.adminSubMenu;
  }

  @override
  set adminSubMenu(bool value) {
    _$adminSubMenuAtom.reportWrite(value, super.adminSubMenu, () {
      super.adminSubMenu = value;
    });
  }

  late final _$_MainViewModelBaseActionController =
      ActionController(name: '_MainViewModelBase', context: context);

  @override
  void init() {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.init');
    try {
      return super.init();
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setBnbIndex(int index) {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.setBnbIndex');
    try {
      return super.setBnbIndex(index);
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeManagerSubMenu() {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.changeManagerSubMenu');
    try {
      return super.changeManagerSubMenu();
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHrSubMenu() {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.changeHrSubMenu');
    try {
      return super.changeHrSubMenu();
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeAdminSubMenu() {
    final _$actionInfo = _$_MainViewModelBaseActionController.startAction(
        name: '_MainViewModelBase.changeAdminSubMenu');
    try {
      return super.changeAdminSubMenu();
    } finally {
      _$_MainViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
bnbIndex: ${bnbIndex},
managerSubMenu: ${managerSubMenu},
hrSubMenu: ${hrSubMenu},
adminSubMenu: ${adminSubMenu}
    ''';
  }
}
