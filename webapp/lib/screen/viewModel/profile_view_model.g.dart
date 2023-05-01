// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileViewModel on _ProfileViewModelBase, Store {
  late final _$profileAtom =
      Atom(name: '_ProfileViewModelBase.profile', context: context);

  @override
  Profile? get profile {
    _$profileAtom.reportRead();
    return super.profile;
  }

  @override
  set profile(Profile? value) {
    _$profileAtom.reportWrite(value, super.profile, () {
      super.profile = value;
    });
  }

  late final _$dataStateAtom =
      Atom(name: '_ProfileViewModelBase.dataState', context: context);

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

  late final _$errorDescriptionAtom =
      Atom(name: '_ProfileViewModelBase.errorDescription', context: context);

  @override
  String? get errorDescription {
    _$errorDescriptionAtom.reportRead();
    return super.errorDescription;
  }

  @override
  set errorDescription(String? value) {
    _$errorDescriptionAtom.reportWrite(value, super.errorDescription, () {
      super.errorDescription = value;
    });
  }

  late final _$initAsyncAction =
      AsyncAction('_ProfileViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
profile: ${profile},
dataState: ${dataState},
errorDescription: ${errorDescription}
    ''';
  }
}
