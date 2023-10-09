import '../helper/api.dart';
import '../models/cart_model.dart';

class GetUserCart {
  Future<CartModel> getUserCart({required int userId}) async {
    List<dynamic> data = await Api().get(url: 'https://fakestoreapi.com/carts');
    List<CartModel> carts =
        data.map((json) => CartModel.fromJSON(json)).toList();
        
    late CartModel cart;
    for (var element in carts) {
      if (element.userId == userId) {
        cart = element;
      }
    }

    return cart;
  }
}
