import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_error.dart';
import '../widgets/product_waiting_card_grid.dart';
import '../provider/category_provider.dart';
import '../services/get_all_categories.dart';
import '../services/get_all_productes.dart';
import '../widgets/products_card_grid.dart';

class ProductsCardGridBuilder extends StatelessWidget {
  const ProductsCardGridBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    final providerCategory = Provider.of<CategoryProvider>(context);
    return FutureBuilder(
      future: providerCategory.category == "all products"
          ? GetAllProductes().getAllProducts()
          : GetAllCategories()
              .getCategoryProducts(categoryName: providerCategory.category),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProductWaitingCardGrid();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ProductsCardGrid(products: snapshot.data!);
        } else {
          return const SliverToBoxAdapter(
            child: CustomError(
              icon: Icons.wifi_off_rounded, 
              errorMessage: 'There Is No Internet Connection',
            ),
          );
        }
      },
    );
  }
}
