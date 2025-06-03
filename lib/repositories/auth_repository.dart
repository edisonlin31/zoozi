import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoozitest/base/api/api.dart';
import 'package:zoozitest/base/utils/cache_manager.dart';
import 'package:zoozitest/models/requests/auth_request.dart';
import 'package:zoozitest/services/auth_service.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository());

class AuthRepository {
  final AuthService service = AuthService(
    Api.client,
    baseUrl: '${Api.baseUrl}/auth',
  );

  AuthRepository();

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await service.login(
        body: AuthRequest(email: email, password: password),
      );
      final jwtToken = response['access_token'];
      await CacheManager.save(CacheConstants.accessToken, jwtToken);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Login failed';
        throw errorMessage;
      } else {
        throw Api.unkownErrorMsg;
      }
    }
  }

  Future<void> register(AuthRequest authRequest) async {
    try {
      await service.register(body: authRequest);
    } catch (e) {
      if (e is DioException && e.response != null) {
        final errorMessage =
            e.response?.data['message'] ?? 'Registration failed';
        throw errorMessage;
      } else {
        throw Api.unkownErrorMsg;
      }
    }
  }
}
