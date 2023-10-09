import 'package:flutter/material.dart';
import 'package:store_app/views/cart_view.dart';
import 'package:store_app/views/edit_user_view.dart';

import '../helper/colors.dart';

PreferredSizeWidget customAppBar(
    {required String title, required BuildContext context}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    title: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 10),
          child: Icon(
            Icons.account_circle,
            color: blueDark2,
            size: 35,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const EditUserView(),
              ),
            );
          },
          child: Text(
            title,
            style: const TextStyle(
              color: blueDark2,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
    actions: [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: blueBright3,
        ),
        child: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CartView(),
              ),
            );
          },
          icon: const Icon(
            Icons.card_giftcard,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );
}
