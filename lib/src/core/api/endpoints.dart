class Endpoints {
  static const String baseUrl = 'http://api.mahmoudtaha.com/api';
  static const String auth = '$baseUrl/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String getBooking = '$baseUrl/get-bookings';
  static const String facilities = '$baseUrl/facilities';
  static const String hotels = '$baseUrl/hotels?count=10&page=1';
  static const String booking = '$baseUrl/create-booking';
  static const String updateBooking = '$baseUrl/update-booking-status';
  static const String searchHotels = '$baseUrl/search-hotels';
  static const String updateInfo = '$baseUrl/auth/update-info';
  static const String userInfo = '$baseUrl/auth/profile-info';
}
