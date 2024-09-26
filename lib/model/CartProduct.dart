
class CartProduct {
  final String id;
  final String title;
  final String thumbnail;
  final String price;
  int quantity;

  CartProduct({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.quantity,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
    id: json['id'],
    title: json['title'],
    thumbnail: json['thumbnail'],
    price: json['price'],
    quantity: json['quantity'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'thumbnail': thumbnail,
    'price': price,
    'quantity': quantity,
  };
}