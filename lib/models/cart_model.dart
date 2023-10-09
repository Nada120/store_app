class CartModel {
  final int userId;
  final List<dynamic> products;

  CartModel({
    required this.userId, 
    required this.products, 
  });

  factory CartModel.fromJSON(Map<String, dynamic> json) => CartModel(
    userId: json['userId'], 
    products: json['products'], 
  );
}
