class HotelImages {
  final String image;

  HotelImages({
    required this.image,
  });

  factory HotelImages.fromJson(Map<String, dynamic> json) {
    return HotelImages(
      image: json["image"],
    );
  }
}
