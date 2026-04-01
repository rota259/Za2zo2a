class ApiEndpoints {
  // Base URL (Change this to your actual backend URL)
  static const String baseUrl = 'https://api.za2zo2a.example.com/v1';

  // Auth
  static const String login = '/auth/login';
  static const String signup = '/auth/signup';
  static const String verifyOtp = '/auth/verify-otp';
  
  // User Profile
  static const String getProfile = '/users/profile';
  static const String updateProfile = '/users/profile';
  
  // Rides
  static const String getRideOptions = '/rides/options';
  static const String requestRide = '/rides/request';
  static const String cancelRide = '/rides/cancel';
  static const String getActiveTrip = '/rides/active';
  static const String submitRating = '/rides/rating';
  
  // History
  static const String getTripHistory = '/users/trips';
  
  // Drivers
  static const String getEarnings = '/driver/earnings';
}
