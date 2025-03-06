class PropertyModel {
  final String title;
  final String image;
  final String location;
  final String price;
  final int beds;
  final int baths;

  PropertyModel({
    required this.title,
    required this.image,
    required this.location,
    required this.price,
    required this.beds,
    required this.baths,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      location: json['location'] ?? '',
      price: json['price'] ?? '',
      beds: json['beds'] ?? 0,
      baths: json['baths'] ?? 0,
    );
  }
}
