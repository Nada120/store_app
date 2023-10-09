import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../views/product_details_view.dart';
import '../helper/colors.dart';
import '../models/product_model.dart';

class CustomCartProduct extends StatelessWidget {
  final ProductModel product;
  const CustomCartProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsView(product: product),
          ),
        );
      },
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: blueDark1, blurRadius: 5, spreadRadius: 0.1),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 6),
                  child: Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      color: blueDark2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.only(bottom: 5),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    color: blueDark1,
                  ),
                  child: Center(
                    child: Text(
                      '${product.rating.rate}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CachedNetworkImage(
              imageUrl: product.image,
              height: 170,
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
                height: 170,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 8),
              child: Text(
                product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: blueDark2,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: grey,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
