// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_detail_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReaderDetailViewModel on _ReaderDetailViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_ReaderDetailViewModelBase.dataState', context: context);

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
      name: '_ReaderDetailViewModelBase.accessLocationList', context: context);

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

  late final _$readerDetailAtom =
      Atom(name: '_ReaderDetailViewModelBase.readerDetail', context: context);

  @override
  ReaderDetail? get readerDetail {
    _$readerDetailAtom.reportRead();
    return super.readerDetail;
  }

  @override
  set readerDetail(ReaderDetail? value) {
    _$readerDetailAtom.reportWrite(value, super.readerDetail, () {
      super.readerDetail = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_ReaderDetailViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$updateReaderAsyncAction =
      AsyncAction('_ReaderDetailViewModelBase.updateReader', context: context);

  @override
  Future updateReader() {
    return _$updateReaderAsyncAction.run(() => super.updateReader());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
accessLocationList: ${accessLocationList},
readerDetail: ${readerDetail}
    ''';
  }
}
