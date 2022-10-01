class BookingUser {
  final int? userId;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? apiToken;
  final String? image;
  final String? createdAt;
  final String? updatedAt;

  const BookingUser({
    this.userId,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.apiToken,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'BookingUser{apiToken: $apiToken}';
  }
}
