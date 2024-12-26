// ignore_for_file: prefer_final_fields, use_rethrow_when_possible

import 'package:event_finder/data/network/base_api_services.dart';
import 'package:event_finder/data/network/network_api_service.dart';
import 'package:event_finder/res/component/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiService();

  /// Fungsi untuk Login
  Future<Map<String, dynamic>> loginApi(dynamic data) async {
    try {
      // Panggil endpoint login
      final response =
          await _apiServices.getPostApiResponse(AppUrl.loginEndPoint, data);

      // Pastikan response berupa Map<String, dynamic>
      if (response is Map<String, dynamic>) {
        return response;
      } else {
        throw Exception("Unexpected response format: $response");
      }
    } catch (e) {
      throw Exception("Login API Error: $e");
    }
  }

  /// Fungsi untuk Register
  Future<Map<String, dynamic>> registerApi(dynamic data) async {
    try {
      // Panggil endpoint register
      final response =
          await _apiServices.getPostApiResponse(AppUrl.registerEndPoint, data);

      // Pastikan response berupa Map<String, dynamic>
      if (response is Map<String, dynamic>) {
        return response;
      } else {
        throw Exception("Unexpected response format: $response");
      }
    } catch (e) {
      throw Exception("Register API Error: $e");
    }
  }
}
