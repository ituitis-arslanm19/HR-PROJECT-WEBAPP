// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reader_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReaderViewModel on _ReaderViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_ReaderViewModelBase.dataState', context: context);

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

  late final _$readerListAtom =
      Atom(name: '_ReaderViewModelBase.readerList', context: context);

  @override
  List<Reader>? get readerList {
    _$readerListAtom.reportRead();
    return super.readerList;
  }

  @override
  set readerList(List<Reader>? value) {
    _$readerListAtom.reportWrite(value, super.readerList, () {
      super.readerList = value;
    });
  }

  late final _$readersAtom =
      Atom(name: '_ReaderViewModelBase.readers', context: context);

  @override
  List<Reader>? get readers {
    _$readersAtom.reportRead();
    return super.readers;
  }

  @override
  set readers(List<Reader>? value) {
    _$readersAtom.reportWrite(value, super.readers, () {
      super.readers = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_ReaderViewModelBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$deleteAsyncAction =
      AsyncAction('_ReaderViewModelBase.delete', context: context);

  @override
  Future delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  late final _$_ReaderViewModelBaseActionController =
      ActionController(name: '_ReaderViewModelBase', context: context);

  @override
  dynamic filter(dynamic name) {
    final _$actionInfo = _$_ReaderViewModelBaseActionController.startAction(
        name: '_ReaderViewModelBase.filter');
    try {
      return super.filter(name);
    } finally {
      _$_ReaderViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
readerList: ${readerList},
readers: ${readers}
    ''';
  }
}
