/// Sample API response shapes for backend integration and local parsing tests.
///
/// Wire [ProfileApiService.fetchProfile] to parse these fields once the backend
/// contract is confirmed. Do not use these maps as UI fallbacks.
class DriverProfileSample {
  DriverProfileSample._();

  /// Expected GET /api/driver/profile/me response.
  static const Map<String, dynamic> profileResponse = {
    'data': {
      'id': 'driver_001',
      'name': 'Ahmed Hassan',
      'email': 'ahmed@example.com',
      'phone': '+201234567890',
      'photo_url': '',
      'rating': 4.85,
      'total_reviews': 128,
      'join_date': '2022-03-15T00:00:00.000Z',
      'online_for': '18 months',
      'completed_trips': 42,
      'target_trips': 50,
      'acceptance_rate': 0.94,
      'cancellation_rate': 0.02,
      'is_online': true,
      'status': 'active',
      'vehicle': {
        'make': 'Toyota',
        'model': 'Corolla',
        'color': 'White',
        'year': '2020',
        'plate': 'ABC-1234',
      },
      'verification': {
        'documents': {
          'profile_photo': {
            'status': 'pending',
            'file_url': 'https://cdn.example.com/photos/driver_001.jpg',
            'uploaded_at': '2025-06-20T10:00:00.000Z',
          },
          'driver_license': {
            'status': 'approved',
            'uploaded_at': '2025-01-10T08:00:00.000Z',
          },
          'national_id': {'status': 'approved'},
          'vehicle_license': {'status': 'not_uploaded'},
          'criminal_record': {'status': 'rejected', 'rejection_reason': 'Expired document'},
        },
      },
    },
  };

  /// Expected POST /api/driver/profile/documents/:type upload response.
  static Map<String, dynamic> uploadResponse(String documentType) => {
        'data': {
          'type': documentType,
          'status': 'pending',
          'uploaded_at': '2025-06-25T12:00:00.000Z',
        },
      };
}
