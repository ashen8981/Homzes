class BackgroundImageModel {
  final String img;

  BackgroundImageModel({required this.img});

  factory BackgroundImageModel.fromJson(Map<String, dynamic> json) {
    return BackgroundImageModel(img: json['img'] ?? '');
  }
}
