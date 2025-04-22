import 'package:app_shopping/constants/Constants.dart';
import 'package:app_shopping/constants/enum/snackbar_type.dart';
import 'package:app_shopping/providers/register_provider.dart';
import 'package:app_shopping/screen/otp_screen.dart';
import 'package:app_shopping/services/logger_services.dart';
import 'package:app_shopping/widgets/custom_toast.dart';
import 'package:app_shopping/widgets/loading_overlay.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app_shopping/models/request/send_otp_request.dart';
import 'package:app_shopping/services/firebase_auth_service.dart';

class RegisterViewModel extends ChangeNotifier {
  final FirebaseAuthService _authService = FirebaseAuthService();

  String? phoneNumber;
  String? verificationId;
  String? error;
  bool isLoading = false;

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

    // Hàm kiểm tra số điện thoại có tồn tại trong hệ thống hay không
  Future<bool> checkPhoneExistence(String phoneNumber) async {
    final dio = Dio();
    try {
      final checkPhoneResponse = await dio.post(
        "$baseUrl/users/check-phone",
        data: {'phoneNumber': phoneNumber},
      );
      final exists = checkPhoneResponse.data['exists'] as bool;
      LoggerServices.info("phone exists: $exists");
      return exists;
    } catch (e) {
      LoggerServices.warning(e);
      return false;
    }
  }

  // Xử lý đăng ký
  Future<void> handleRegister({
    required String phoneNumber,
    required RegisterProvider provider,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();

      // Kiểm tra tồn tại
      final isPhoneExist = await checkPhoneExistence(phoneNumber);
      if (isPhoneExist) {
        if (context.mounted) {
          CustomToast.show(
            context: context,
            title: "Thông báo",
            message: "Số điện thoại đã đăng ký",
            backgroundColor: kWhite, 
            textColor: kGray, 
            type: SnackbarType.warning,
          );
        }     
        return;
      }

      // Gửi OTP
      final otpSent = await sendOtp(phoneNumber);
      if (otpSent) {
        provider.setPhoneNumber(phoneNumber);
        provider.setVerificationId(verificationId!);

        LoggerServices.info("📞 Gửi OTP đến $phoneNumber");
        if (context.mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const OtpScreen()),
          );
        }
       
      } else {
        if (context.mounted) {
          CustomToast.show(        
            context: context, 
            title: "Thông báo", 
            message: "Lỗi gửi OTP", 
            backgroundColor: kWhite, 
            textColor: kGray, 
            type: SnackbarType.error
          );
        }     
      }
    } catch (e) {
      LoggerServices.error(e);
        if(context.mounted){
          CustomToast.show(
            context: context, 
            title: "Lỗi", 
            message: "Đã xảy ra lỗi trong quá trình đăng ký.", 
            backgroundColor: kWhite, 
            textColor: kGray, 
            type: SnackbarType.error
          );
        }       
    } finally {
      isLoading = false;
      notifyListeners();
      if (context.mounted) {
        LoadingOverlay.hide(context);
      }
    }
  }
 
}
