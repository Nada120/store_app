import 'dart:convert';

import '../helper/api.dart';

class AddNewCart {
  
  Future<String> addNewCart({
    required num userId,
    required DateTime date,
    required num productId,
    required num quantity,
  }) async {
    await Api().post(
      url: 'https://fakestoreapi.com/carts',
      body: jsonEncode(<String, dynamic>{
        "userId": userId,
        "date": date.toString(),
        "products": [
          {"productId": productId, "quantity": quantity}
        ],
      }),
      token: null,
    );

    return 'The Product was Added To The Cart';
  }
}
