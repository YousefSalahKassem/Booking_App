class BookingUser {
  final int? userId;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? apiToken;
  final String? image;
  final String? createdAt;
  final String? updatedAt;
  final String? googleId;

  const BookingUser({
    required this.userId,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    required this.apiToken,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.googleId,
  });
}
