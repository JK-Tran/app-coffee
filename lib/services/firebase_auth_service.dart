import 'package:app_shopping/services/logger_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId; // Dùng nullable để kiểm tra null

  // Gửi OTP
  Future<void> sendOtp(String phoneNumber, Function(String) onCodeSent) async {
  await _auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    timeout: const Duration(seconds: 120),
    verificationCompleted: (PhoneAuthCredential credential) async {
      await _auth.signInWithCredential(credential);
    },
    verificationFailed: (FirebaseAuthException e) {
      LoggerServices.error("Lỗi gửi OTP: ${e.message}");
    },
    codeSent: (String verId, int? resendToken) {
     LoggerServices.info("📩 OTP đã gửi! verificationId: $verId");
      onCodeSent(verId); // Gửi verificationId sang màn hình OTP
    },
    codeAutoRetrievalTimeout: (String verId) {},
  );
}

  // Xác thực OTP
 Future<User?> verifyOtp(String verificationId, String smsCode) async {
  try {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  } catch (e) {
    LoggerServices.error("Lỗi xác thực OTP: $e");
    return null; 
  }
}

}
