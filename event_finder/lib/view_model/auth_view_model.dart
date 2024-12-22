
import 'package:event_finder/repository/auth_repository.dart';
import 'package:event_finder/utils/routes/routes_name.dart';
import 'package:event_finder/utils/utils.dart';
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

  Future<void> loginApi(dynamic data, BuildContext context) async {

    setLoading(true);

    _myRepo.loginApi(data).then((value) {
      setLoading(false);
      Utils.toastMessage('Login Successfully');
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      Utils.toastMessage(error.toString());
      if(kDebugMode) {
        print(error.toString());
      }
    });
  }

  Future<void> registerApi(dynamic data, BuildContext context) async {

    setRegisterLoading(true);

    _myRepo.registerApi(data).then((value) {
      setLoading(false);
      Utils.toastMessage('Register Successfully');
      Navigator.pushNamed(context, RoutesName.home);
      if (kDebugMode) {
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setRegisterLoading(false);
      Utils.toastMessage(error.toString());
      if(kDebugMode) {
        print(error.toString());
      }
    });
  }
}