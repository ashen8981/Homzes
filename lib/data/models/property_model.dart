class PropertyModel {
  final String title;
  final String image;
  final String location;
  final String price;
  final String beds;
  final String baths;

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
      price: json['price'].toString(),
      beds: json['beds'].toString(),
      baths: json['baths'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
      'location': location,
      'price': price,
      'beds': beds,
      'baths': baths,
    };
  }
}
