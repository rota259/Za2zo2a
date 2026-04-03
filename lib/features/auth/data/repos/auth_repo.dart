import '../../../../core/network/dio_client.dart';
import '../models/auth_model.dart';

class AuthRepo {
  final DioClient _dioClient;

  AuthRepo(this._dioClient);

  Future<AuthModel> login(String email, String password) async {
    // TODO: Connect to real API
    // Ensure we have a fake delay for dummy login
    await Future.delayed(const Duration(seconds: 2));

    // final response = await _dioClient.dio.post(
    //   ApiEndpoints.login,
    //   data: {'email': email, 'password': password},
    // );
    // return AuthModel.fromJson(response.data);

    // Mock response
    if (email == 'error@test.com') {
      throw Exception('Invalid credentials');
    }

    return AuthModel(
      id: '1',
      name: 'Alex Volt',
      email: email,
      phone: '+1 234 567 8900',
      token: 'fake-jwt-token-12345',
    );
  }

  Future<AuthModel> signup(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    await Future.delayed(const Duration(seconds: 2));

    return AuthModel(
      id: '2',
      name: name,
      email: email,
      phone: phone,
      token: 'fake-jwt-token-67890',
    );
  }
}
