import 'package:webapp/core/base/base_view_model.dart';
import 'package:webapp/core/constant/enum/enums.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/screen/service/product_service.dart';
import 'package:mobx/mobx.dart';

import '../model/product.dart';
part 'product_view_model.g.dart';

class ProductViewModel = _ProductViewModelBase with _$ProductViewModel;

abstract class _ProductViewModelBase extends BaseViewModel with Store {
  final ProductService productService;

  _ProductViewModelBase(this.productService);

  @observable
  DataState dataState = DataState.LOADING;
  @observable
  List<Product>? products;
  @observable
  String? errorDescription;

  @action
  @override
  Future<void> init() async {
    ResponseModel<List<Product>?> result = await productService.getProducts();

    if ((!result.error!) && result.data != null) {
      products = result.data;
      products!.isEmpty
          ? dataState = DataState.EMPTY
          : dataState = DataState.READY;
    } else {
      errorDescription = result.description;
      dataState = DataState.ERROR;
    }
  }
}
