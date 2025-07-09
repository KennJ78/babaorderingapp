import 'package:flutter/material.dart';

class User {
  String name;
  String email;
  String? profileImagePath;

  User({required this.name, required this.email, this.profileImagePath});
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setProfileImage(String path) {
    if (_user != null) {
      _user!.profileImagePath = path;
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
} 