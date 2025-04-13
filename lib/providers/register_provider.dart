// lib/providers/register_provider.dart
import 'package:flutter/material.dart';

class RegisterProvider with ChangeNotifier {
  String _verificationId = '';
  String _phoneNumber = '';
  String _uid = '';

  String get verificationId => _verificationId;
  String get phoneNumber => _phoneNumber;
  String get uid => _uid;

  void setVerificationId(String id) {
    _verificationId = id;
    notifyListeners();
  }

  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
    notifyListeners();
  }

  void setUID (String uid){
    _uid = uid;
    notifyListeners();
  }

  void clear() {
    _verificationId = '';
    _phoneNumber = '';
    _uid = '';
    notifyListeners();
  }
}
