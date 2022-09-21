class Endpoints {
  static const String baseUrl = 'http://api.mahmoudtaha.com/api';
  static const String auth = '$baseUrl/auth';
  static const String login = '$auth/login';
  static const String register = '$auth/register';
  static const String facilites = '$baseUrl/facilities';
  static const String hotels = '$baseUrl/hotels?count=10&page=1';
}
