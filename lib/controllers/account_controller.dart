import 'package:flutter/cupertino.dart';
import 'package:mental_health_app/models/user.dart';

class AccountController with ChangeNotifier {
  User? _user;

  Future<void> fetchAndSetAccount() async {
    try {} catch (e) {
      rethrow;
    }
  }
}
