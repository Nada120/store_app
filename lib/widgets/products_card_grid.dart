import 'package:flutter/material.dart';
import 'package:store_app/models/product_model.dart';
import 'package:store_app/widgets/custom_cart_product.dart';

class ProductsCardGrid extends StatelessWidget {
  final List<ProductModel> products;
  const ProductsCardGrid({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: (size.width / size.height*1.2),
          ),
        delegate: SliverChildBuilderDelegate(
          childCount: products.length,
          (context, index) => CustomCartProduct(
            product: products[index],
          ),
        ),
      ),
    );
  }
}
