// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_off_approval_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimeOffApprovalViewModel on _TimeOffApprovalViewModelBase, Store {
  late final _$dataState1Atom =
      Atom(name: '_TimeOffApprovalViewModelBase.dataState1', context: context);

  @override
  DataState get dataState1 {
    _$dataState1Atom.reportRead();
    return super.dataState1;
  }

  @override
  set dataState1(DataState value) {
    _$dataState1Atom.reportWrite(value, super.dataState1, () {
      super.dataState1 = value;
    });
  }

  late final _$dataState2Atom =
      Atom(name: '_TimeOffApprovalViewModelBase.dataState2', context: context);

  @override
  DataState get dataState2 {
    _$dataState2Atom.reportRead();
    return super.dataState2;
  }

  @override
  set dataState2(DataState value) {
    _$dataState2Atom.reportWrite(value, super.dataState2, () {
      super.dataState2 = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_TimeOffApprovalViewModelBase.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$approvedTimeOffsAtom = Atom(
      name: '_TimeOffApprovalViewModelBase.approvedTimeOffs', context: context);

  @override
  ObservableList<ApprovedTimeOff>? get approvedTimeOffs {
    _$approvedTimeOffsAtom.reportRead();
    return super.approvedTimeOffs;
  }

  @override
  set approvedTimeOffs(ObservableList<ApprovedTimeOff>? value) {
    _$approvedTimeOffsAtom.reportWrite(value, super.approvedTimeOffs, () {
      super.approvedTimeOffs = value;
    });
  }

  late final _$pendingTimeOffsAtom = Atom(
      name: '_TimeOffApprovalViewModelBase.pendingTimeOffs', context: context);

  @override
  ObservableList<ApprovedTimeOff>? get pendingTimeOffs {
    _$pendingTimeOffsAtom.reportRead();
    return super.pendingTimeOffs;
  }

  @override
  set pendingTimeOffs(ObservableList<ApprovedTimeOff>? value) {
    _$pendingTimeOffsAtom.reportWrite(value, super.pendingTimeOffs, () {
      super.pendingTimeOffs = value;
    });
  }

  late final _$updateTimeOffAsyncAction = AsyncAction(
      '_TimeOffApprovalViewModelBase.updateTimeOff',
      context: context);

  @override
  Future updateTimeOff(bool value, int id) {
    return _$updateTimeOffAsyncAction.run(() => super.updateTimeOff(value, id));
  }

  @override
  String toString() {
    return '''
dataState1: ${dataState1},
dataState2: ${dataState2},
description: ${description},
approvedTimeOffs: ${approvedTimeOffs},
pendingTimeOffs: ${pendingTimeOffs}
    ''';
  }
}
