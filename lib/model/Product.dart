
class ProductItem {
  final String? id;
  final String? name;
  final String? slug;
  final String? type;
  final String? status;
  final String? description;
  final String? short_description;
  final String? price;
  final String? regular_price;
  final String? sale_price;
  final String? stock_quantity;
  final String? imageUrl; // Add a field for the image URL

  ProductItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.type,
    required this.status,
    required this.description,
    required this.short_description,
    required this.price,
    required this.regular_price,
    required this.sale_price,
    required this.stock_quantity,
    required this.imageUrl,
  });

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    // Extract the image src from the JSON, or use a default image if not available
    final imageSrc = json['images'] != null &&
        json['images'].isNotEmpty &&
        json['images'][0]['src'] != null
        ? json['images'][0]['src']
        : 'https://perfumecenter.com.bd/wp-content/uploads/2021/11/PC-LOGO-Mobile.png';

    return ProductItem(
      id: json["id"].toString(),
      name: json["name"],
      slug: json["slug"],
      type: json["type"],
      status: json["status"],
      description: json["description"],
      short_description: json["short_description"],
      price: json["price"],
      regular_price: json["regular_price"],
      sale_price: json["sale_price"],
      stock_quantity: json["stock_quantity"].toString(),
      imageUrl: imageSrc,
    );
  }
}
