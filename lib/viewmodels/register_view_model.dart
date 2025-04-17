import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_shopping/models/request/send_otp_request.dart';
import 'package:app_shopping/services/firebase_auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  String? phoneNumber;
  String? verificationId;
  String? error;

  Future<bool> sendOtp(String rawPhone) async {
    phoneNumber = rawPhone;
    final request = SendOtpRequest(phoneNumber: rawPhone);
    final response = await _authService.sendOTP(request);

    if (response.success) {
      verificationId = response.verificationId;
      return true;
    } else {
      error = response.message;
      return false;
    }
  }

  Future<User?> verifyOtp(String smsCode) async {
    if (verificationId == null) {
      error = "Không có mã xác thực. Vui lòng gửi lại OTP.";
      return null;
    }

    final user = await _authService.verifyOtp(verificationId!, smsCode);
    if (user == null) {
      error = "Mã OTP không hợp lệ.";
    }
    return user;
  }
}
