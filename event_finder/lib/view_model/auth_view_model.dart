import 'package:event_finder/repository/auth_repository.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/utils/utils.dart';
import 'package:event_finder/view_model/user_preferences.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _registerLoading = false;
  bool get registerLoading => _registerLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setRegisterLoading(bool value) {
    _registerLoading = value;
    notifyListeners();
  }

  final String _userId = '';
  String get userId => _userId;

  final String _token = '';
  String get token => _token;

  final String _role = '';
  String get role => _role;

  Future<void> loginApi(dynamic data, BuildContext context) async {
    setLoading(true);

    try {
      // Panggil API login dan ambil response dari server
      final response = await _myRepo.loginApi(data);

      // Parsing respons
      String userId = response['data']['id']; 
      String? role = response['data']['role'];
      String? token = response['data']['token'];

      // Validasi data
      if (userId.isEmpty || role == null || token == null) {
        throw Exception("Invalid response: Missing userId, role, or token");
      }

      // Simpan token, userId, dan role ke SharedPreferences
      print('Saving data: userId=$userId, token=$token, role=$role');
      await UserPreferences.saveUserData(userId, token, role);
      print('Data saved successfully');

      Utils.toastMessage('Login Successfully');
      Navigator.pushReplacementNamed(context,
          role == 'organizer' ? RoutesName.adminHome : RoutesName.superAdmin);
      if (kDebugMode) {
        print('Login Response: $response');
      } else {
        Utils.toastMessage('Invalid credentials');
      }
    } catch (error) {
      
      Utils.toastMessage('Login Failed: $error');
      if (kDebugMode) {
        print('Login Error: $error');
      }
    } finally {
      setLoading(false);
    }
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {
    setRegisterLoading(true);

    try {
      // Panggil API register dan ambil response dari server
      final response = await _myRepo.registerApi(data);
      print(response);

      Utils.toastMessage('Register Successfully');
      Navigator.pushNamed(context, RoutesName.login);
      if (kDebugMode) {
        print('Register Response: $response');
      }
    } catch (error) {
      Utils.toastMessage('Register Failed: $error');
      if (kDebugMode) {
        print('Register Error: $error');
      }
    } finally {
      setRegisterLoading(false);
    }
  }
}
