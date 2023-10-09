import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../helper/colors.dart';
import '../models/product_model.dart';
import '../models/products_cart_model.dart';

class CustomListCart extends StatelessWidget {
  final List<ProductModel> products;
  final List<ProductsCartModel> cartProducts;

  const CustomListCart({
    super.key,
    required this.products,
    required this.cartProducts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: products.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: 100.0, left: 10, right: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            PhysicalModel(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              elevation: 10,
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    products[index].title,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                      color: blueDark2,
                    ),
                  ),
                ),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          customText('PRICE: ${products[index].price} \$'),
                          customText(
                              'QUANTITY: ${cartProducts[index].quantity}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              right: 50,
              child: CachedNetworkImage(
                imageUrl: products[index].image,
                height: 100,
                width: 100,
                fit: BoxFit.fill,
                placeholder: (context, url) => const SizedBox(
                  width: 60,
                  height: 60,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: blueDark2,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/error.gif',
                  height: 70,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget customText(String text) {
  return Container(
    padding: const EdgeInsets.all(4),
    margin: const EdgeInsets.only(right: 5, bottom: 10),
    decoration: BoxDecoration(
      color: blueBright3,
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
