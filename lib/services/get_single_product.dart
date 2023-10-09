import 'package:store_app/helper/api.dart';

import '../models/product_model.dart';

class GetSingleProduct {
  Future<ProductModel> getSingleProduct({required int id}) async {
    final data = await Api().get(url: 'https://fakestoreapi.com/products/$id');
    return ProductModel.formJSON(data);
  }
}
