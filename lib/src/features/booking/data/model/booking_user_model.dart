import 'package:bookingapp/src/features/booking/domain/entity/booking_users.dart';

class BookingUserModel extends BookingUser {
  const BookingUserModel({
    required super.userId,
    required super.name,
    required super.email,
    required super.emailVerifiedAt,
    required super.apiToken,
    required super.image,
    required super.createdAt,
    required super.updatedAt,
    required super.googleId,
  });

  factory BookingUserModel.fromJson(Map<String, dynamic> json) {
    return BookingUserModel(
      userId: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      apiToken: json['api_token'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      googleId: json['google_id'],
    );
  }
}
