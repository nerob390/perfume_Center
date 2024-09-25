
class CategoryItem {
  static const String defaultImageUrl = 'https://perfumecenter.com.bd/wp-content/uploads/2021/11/PC-LOGO-Mobile.png';

  final int id;
  final String name;
  final String slug;
  final String image;

  CategoryItem({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    // Extract the image object or handle if it's null
    final imageObject = json["image"] as Map<String, dynamic>?;

    // Use null-aware operators to safely access properties
    final imageSrc = imageObject?["src"] as String? ?? defaultImageUrl;

    return CategoryItem(
      id: json["id"] as int,
      name: json["name"] as String,
      slug: json["slug"] as String,
      image: imageSrc,
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": {
      "src": image,
    },
  };
}

