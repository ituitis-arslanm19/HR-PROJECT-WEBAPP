// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:webapp/core/constant/strings.dart';
import 'package:webapp/core/network/model/response_model.dart';
import 'package:webapp/core/network/network_manager.dart';

import '../../core/constant/enum/enums.dart';
import '../model/product.dart';

class ProductService {
  NetworkManager networkManager;
  ProductService({
    required this.networkManager,
  });

  Future<ResponseModel<List<Product>?>> getProducts() async {
    ResponseModel<List<Product>?> result =
        await networkManager.send<List<Product>, Product>(
            "product", HttpMethod.GET, Product(), null, TOKEN);
    return result;
  }
}
