import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_shopping/models/request/send_otp_request.dart';
import 'package:app_shopping/models/response/send_otp_response.dart';
import 'package:app_shopping/services/logger_services.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Gửi OTP
  Future<SendOtpResponse> sendOTP(SendOtpRequest request) async {
    final completer = Completer<SendOtpResponse>();

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: request.phoneNumber,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          LoggerServices.info("✅ Tự động xác thực thành công.");
          await _auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          LoggerServices.error("❌ Gửi OTP thất bại: ${e.message}");
          completer.complete(SendOtpResponse(
            verificationId: '',
            success: false,
            message: e.message,
          ));
        },
        codeSent: (String verId, int? resendToken) {
          LoggerServices.info("📩 OTP đã gửi. verificationId: $verId");
          
          completer.complete(SendOtpResponse(
            verificationId: verId,
            success: true,
            message: "OTP đã được gửi",
          ));
        },
        codeAutoRetrievalTimeout: (String verId) {
          LoggerServices.warning("⏳ Hết thời gian tự động xác thực.");
        },
      );
    } catch (e) {
      LoggerServices.error("🚨 Lỗi không xác định khi gửi OTP: $e");
      completer.complete(SendOtpResponse(
        verificationId: '',
        success: false,
        message: e.toString(),
      ));
    }

    return completer.future;
  }

  // Xác thực OTP
  Future<User?> verifyOtp(String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      LoggerServices.info("✅ OTP xác thực thành công cho user: ${userCredential.user?.uid}");
      return userCredential.user;
    } catch (e) {
      LoggerServices.error("❌ Xác thực OTP thất bại: $e");
      return null;
    }
  }
}
