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

  Future<void> loginApi(dynamic data, BuildContext context,
      {required VoidCallback onSuccess}) async {
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

      // Tampilkan pesan sukses
      Utils.toastMessage('Login Successfully');

      // Panggil onSuccess callback jika login berhasil
      onSuccess();

      // Navigasi berdasarkan role setelah proses login berhasil
      if (role == 'organizer') {
        Navigator.pushReplacementNamed(context, RoutesName.adminHome);
      } else {
        Navigator.pushReplacementNamed(context, RoutesName.superAdmin);
      }

      if (kDebugMode) {
        print('Login Response: $response');
      }
    } catch (error) {
      // Menampilkan pesan error
      Utils.toastMessage('Login Failed');
      if (kDebugMode) {
        print('Login Error: $error');
      }
      // Menutup dialog loading jika terjadi error
      Navigator.of(context).pop();
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
      Utils.toastMessage('Register Failed');
      if (kDebugMode) {
        print('Register Error: $error');
      }
    } finally {
      setRegisterLoading(false);
    }
  }
}
