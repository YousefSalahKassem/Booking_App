class BookingHotelImages {
  final String image;

  BookingHotelImages({
    required this.image,
  });

  factory BookingHotelImages.fromJson(Map<String, dynamic> json) {
    return BookingHotelImages(
      image: json["image"],
    );
  }
}
