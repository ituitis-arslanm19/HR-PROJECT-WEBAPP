// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductViewModel on _ProductViewModelBase, Store {
  late final _$dataStateAtom =
      Atom(name: '_ProductViewModelBase.dataState', context: context);

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

  late final _$productsAtom =
      Atom(name: '_ProductViewModelBase.products', context: context);

  @override
  List<Product>? get products {
    _$productsAtom.reportRead();
    return super.products;
  }

  @override
  set products(List<Product>? value) {
    _$productsAtom.reportWrite(value, super.products, () {
      super.products = value;
    });
  }

  late final _$errorDescriptionAtom =
      Atom(name: '_ProductViewModelBase.errorDescription', context: context);

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
      AsyncAction('_ProductViewModelBase.init', context: context);

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  @override
  String toString() {
    return '''
dataState: ${dataState},
products: ${products},
errorDescription: ${errorDescription}
    ''';
  }
}
