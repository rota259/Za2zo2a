class ApiEndpoints {
  ApiEndpoints._();

  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://192.168.1.11:3000',
  );

  // ── Auth ────────────────────────────────────────────────────────────────
  static const String register = '/api/auth/register';
  static const String login = '/api/auth/login';
  static const String me = '/api/auth/me';
  static const String deleteAccount = '/api/auth/delete-account';

  // ── Map ─────────────────────────────────────────────────────────────────
  static const String geocode = '/api/map/geocode';
  static const String reverseGeocode = '/api/map/reverse-geocode';
  static const String route = '/api/map/route';

  // ── Trips ───────────────────────────────────────────────────────────────
  static const String trips = '/api/trips';
  static const String availableTrips = '/api/trips/available';
  static String trip(String id) => '/api/trips/$id';
  static String acceptTrip(String id) => '/api/trips/$id/accept';
  static String startTrip(String id) => '/api/trips/$id/start';
  static String completeTrip(String id) => '/api/trips/$id/complete';
  static String cancelTrip(String id) => '/api/trips/$id/cancel';
  static String rateTrip(String id) => '/api/trips/$id/rate';
  static const String activeTrip = '/api/trips/active';
  static const String tripHistory = '/api/trips/history';

  // ── Driver ──────────────────────────────────────────────────────────────
  // Status & location
  static const String driverStatus = '/api/driver/status';
  static const String driverLocation = '/api/driver/location';

  // Profile
  static const String driverProfile = '/api/driver/profile';
  static String driverProfileById(String id) => '/api/driver/profile/$id';
  static const String driverEditProfile = '/api/driver/profile/me';
  static const String driverProfilePhoto = '/api/driver/profile/photo';

  // Data
  static const String driverStats = '/api/driver/stats';
  static const String driverEarnings = '/api/driver/earnings';
  static const String driverBalance = '/api/driver/balance';
  static const String driverBonus = '/api/driver/bonus';
  static const String driverTrips = '/api/driver/trips';

  // Payout
  static const String driverWallet = '/api/driver/wallet';
  static const String driverBank = '/api/driver/bank';

  // Documents
  static const String driverDocuments = '/api/driver/documents';
  static String driverDocumentUpload(String type) =>
      '/api/driver/documents/$type';

  // ── Health ──────────────────────────────────────────────────────────────
  static const String health = '/health';
}
