class CreateBookingEntity {
  final String hotelId;
  final String userId;
  final String? type;

  CreateBookingEntity({required this.hotelId, this.userId = "10", this.type});
}
