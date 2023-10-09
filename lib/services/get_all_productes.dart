import '../helper/api.dart';
import '../models/product_model.dart';

class GetAllProductes {
  Future<List<ProductModel>> getAllProducts() async {
    List<dynamic> data =
        await Api().get(url: 'https://fakestoreapi.com/products');
    List<ProductModel> products =
        data.map((json) => ProductModel.formJSON(json)).toList();

    return products;
  }
}
