import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/cache/secure_storage.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/input_text.dart';
import 'package:webapp/core/widgets/other/product_card.dart';
import 'package:webapp/core/widgets/other/profile_card.dart';
import 'package:webapp/core/widgets/other/time_off_approval_card.dart';
import 'package:webapp/screen/service/product_service.dart';
import 'package:webapp/screen/viewModel/product_view_model.dart';

import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';
import '../../core/widgets/other/button.dart';
import '../../core/widgets/other/time_off_card.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    ProductViewModel productViewModel = ProductViewModel(
        ProductService(networkManager: NetworkManager(SecureStorage())));
    productViewModel.init();

    SizeConfig().init(context);
    return buildProducts(theme, colorScheme, productViewModel);
  }

  Column buildProducts(ThemeData theme, ColorScheme colorScheme,
      ProductViewModel productViewModel) {
    return Column(
      children: [
        Observer(builder: (_) {
          switch (productViewModel.dataState) {
            case DataState.READY:
              return buildProductList(productViewModel);
            case DataState.ERROR:
              return Center(child: Text("Hata meydana geldi."));
            case DataState.LOADING:
              return Center(
                child: CircularProgressIndicator(),
              );
            case DataState.EMPTY:
              return Center(
                  child: Text("Üzerinize zimmetli ürün bulunmamakta"));
          }
        }),
      ],
    );
  }

  SizedBox buildProductList(ProductViewModel productViewModel) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 60,
        child: Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...productViewModel.products!.map(
                    (element) => SizedBox(
                      height: SizeConfig.blockSizeVertical * 10,
                      width: SizeConfig.blockSizeHorizontal * 60,
                      child: Padding(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: ProductCard(
                            name: element.name!,
                            date: element.dateOfIssue!,
                          )),
                    ),
                  )
                ],
              )),
        ));
  }
}
