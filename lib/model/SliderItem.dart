import 'dart:convert';

List<SliderItem> countryFromJson(String str) =>
    List<SliderItem>.from(json.decode(str).map((x) => SliderItem.fromJson(x)));


String countryToJson(List<SliderItem> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class SliderItem {
  String image;


  SliderItem({
    required this.image,
  });

  factory SliderItem.fromJson(Map<String, dynamic> json) => SliderItem(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,

  };
}