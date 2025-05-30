import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _userId;
  String? _username;
  bool _isAuthenticated = false;

  String? get userId => _userId;
  String? get username => _username;
  bool get isAuthenticated => _isAuthenticated;

  Future<void> signUp(String email, String password, String username) async {
    try {
      // TODO: Implement actual Firebase authentication
      _userId = "temp_user_id";
      _username = username;
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      // TODO: Implement actual Firebase authentication
      _userId = "temp_user_id";
      _username = "temp_username";
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      // TODO: Implement actual Firebase sign out
      _userId = null;
      _username = null;
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
