import 'package:store_app/helper/api.dart';
import 'package:store_app/models/product_model.dart';

class GetAllCategories {
  Future<List<dynamic>> getAllCategoriesNames() async {
    List<dynamic> categoriesName =
        await Api().get(url: 'https://fakestoreapi.com/products/categories');
    categoriesName.insertAll(0, ['all products']);

    return categoriesName;
  }

  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryName}) async {
    List<dynamic> data = await Api()
        .get(url: 'https://fakestoreapi.com/products/category/$categoryName');
    List<ProductModel> categoryProducts =
        data.map((json) => ProductModel.formJSON(json)).toList();

    return categoryProducts;
  }
}
