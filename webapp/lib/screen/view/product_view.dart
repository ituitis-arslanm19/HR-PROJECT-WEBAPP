import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:webapp/core/network/network_manager.dart';
import 'package:webapp/core/widgets/other/product_card.dart';
import 'package:webapp/screen/service/product_service.dart';
import 'package:webapp/screen/viewModel/product_view_model.dart';
import '../../core/base/base_view.dart';
import '../../core/constant/enum/enums.dart';
import '../../core/util/size_config.dart';

class ProductView extends StatelessWidget {
  ProductView({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BaseView<ProductViewModel>(
        viewModel:
            ProductViewModel(ProductService(networkManager: NetworkManager())),
        onModelReady: (model) {
          model.init();
        },
        onPageBuilder: (context, viewModel, theme) =>
            buildProducts(theme, theme.colorScheme, viewModel));
  }

  Column buildProducts(
      ThemeData theme, ColorScheme colorScheme, ProductViewModel viewModel) {
    return Column(
      children: [
        Observer(builder: (_) {
          switch (viewModel.dataState) {
            case DataState.READY:
              return buildProductList(viewModel);
            case DataState.ERROR:
              return const Center(child: Text("Hata meydana geldi."));
            case DataState.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DataState.EMPTY:
              return Expanded(
                child: const Center(
                    child: Text("Üzerinize zimmetli ürün bulunmamakta")),
              );
          }
        }),
      ],
    );
  }

  SizedBox buildProductList(ProductViewModel viewModel) {
    return SizedBox(
        width: SizeConfig.blockSizeHorizontal * 60,
        child: Center(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  ...viewModel.products!.map(
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
