import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_list_cart.dart';
import '../models/product_model.dart';
import '../services/get_single_product.dart';
import '../services/get_user_cart.dart';
import '../helper/colors.dart';
import '../models/products_cart_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<ProductsCartModel>? cartProducts;
  List<ProductModel>? products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserCart();
  }

  void getUserCart() async {
    var prefs = await SharedPreferences.getInstance();
    int userId = prefs.getInt("userId")!;
    await GetUserCart().getUserCart(userId: userId).then((cart) async {
      cartProducts =
          cart.products.map((e) => ProductsCartModel.fromJSON(e)).toList();
      for (var element in cartProducts!) {
        var product =
            await GetSingleProduct().getSingleProduct(id: element.productId);
        setState(() {
          products!.add(product);
        });
      }
    }).catchError((onError) {
      debugPrint('There is an error which is: $onError');
    });
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: blueDark2,
          size: 40,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_circle_left_rounded),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Cart',
          style: TextStyle(
            color: blueDark2,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: blueDark2,
              ),
            )
          : products!.isNotEmpty
              ? CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    CustomListCart(
                      products: products!,
                      cartProducts: cartProducts!,
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 40),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                              BoxShadow(
                                color: grey2,
                                blurRadius: 6,
                                offset: Offset(2, 4),
                              ),
                            ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${products!.length} items',
                              style: const TextStyle(
                                color: grey2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: ${totalPrice()} \$',
                              style: const TextStyle(
                                color: blueDark2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    'No Items Was Added Here!!',
                    style: TextStyle(
                      color: grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
    );
  }

  double totalPrice() {
    double total = 1;
    for (var element in products!) {
      total *= element.price;
    }
    return total;
  }
}
