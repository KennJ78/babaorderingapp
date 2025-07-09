import 'package:flutter/material.dart';

class User {
  String name;
  String? username;
  String email;
  String? profileImagePath;
  String? address;
  String? city;
  String? state;
  String? zipCode;
  String? phoneNumber;

  User({
    required this.name, 
    this.username,
    required this.email, 
    this.profileImagePath,
    this.address,
    this.city,
    this.state,
    this.zipCode,
    this.phoneNumber,
  });
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

  void updateUserAddress({
    String? address,
    String? city,
    String? state,
    String? zipCode,
    String? phoneNumber,
  }) {
    if (_user != null) {
      if (address != null) _user!.address = address;
      if (city != null) _user!.city = city;
      if (state != null) _user!.state = state;
      if (zipCode != null) _user!.zipCode = zipCode;
      if (phoneNumber != null) _user!.phoneNumber = phoneNumber;
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }
} 