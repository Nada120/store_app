class ProductsCartModel {
  final int productId;
  final int quantity;

  ProductsCartModel({required this.productId, required this.quantity});

  factory ProductsCartModel.fromJSON(Map<String, dynamic> json) =>
      ProductsCartModel(
          productId: json['productId'], quantity: json['quantity']);
}
