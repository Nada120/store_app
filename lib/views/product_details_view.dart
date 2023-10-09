import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/add_new_cart.dart';
import '../widgets/custom_button.dart';
import '../helper/colors.dart';
import '../models/product_model.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  int quantity = 1;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: blueDark2,
      progressIndicator: const CircularProgressIndicator(
        color: blueDark2,
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              blueBright1,
              blueBright2,
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(
              color: blueDark2,
              size: 40,
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_circle_left),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  widget.product.title,
                  maxLines: 3,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    color: blueDark2,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(
                  widget.product.category,
                  style: const TextStyle(
                    color: grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: blueBright3,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.product.rating.rate.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.star_purple500_outlined,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      color: grey2,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: widget.product.image,
                        height: 150,
                        width: 150,
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
                          height: 150,
                          width: 150,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 5),
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: blueDark2,
                        ),
                      ),
                    ),
                    Text(
                      widget.product.description,
                      maxLines: 7,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: blueDark1,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'PRICE  ${widget.product.price} \$',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        rowQuantity(),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: CustomButton(
                        title: 'ADD TO CART',
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          SharedPreferences.getInstance().then((prefs) async {
                            int userId = prefs.getInt("userId")!;
                            AddNewCart()
                                .addNewCart(
                              userId: userId,
                              date: DateTime.now(),
                              productId: widget.product.id,
                              quantity: quantity,
                            )
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(value),
                                ),
                              );
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowQuantity() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: blueDark2,
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            'QUANTITY',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              quantity == 1 ? quantity = 1 : --quantity;
            });
          },
          icon: const Icon(
            Icons.arrow_circle_left_rounded,
            color: blueDark2,
            size: 35,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            quantity.toString(),
            style: const TextStyle(
              color: blueDark2,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              ++quantity;
            });
          },
          icon: const Icon(
            Icons.arrow_circle_right_rounded,
            color: blueDark2,
            size: 35,
          ),
        ),
      ],
    );
  }
}
