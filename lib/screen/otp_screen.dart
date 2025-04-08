import 'package:app_shopping/constants/constants.dart';
import 'package:app_shopping/screen/InfoRegister.dart';
import 'package:app_shopping/services/firebase_auth_service.dart';
import 'package:app_shopping/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId; // Thêm tham số này
  final String phoneNumber;
  const OtpScreen({super.key, required this.verificationId, required this.phoneNumber});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final FirebaseAuthService _authService = FirebaseAuthService();
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back,size: 30.sp,)
                  ),
                ),
                SizedBox(height: 50.h,),
                Image.asset('assets/images/otp_img.jpg',height: 300.h,),
                 SizedBox(height: 10.h,),
                Text("Nhập mã OTP gửi đến số điện thoại",
                textAlign: TextAlign.center,
                      style: TextStyle(
                        color: kGray,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold
                      ),
                ),
                SizedBox(height: 20.h),   
                Pinput(
                  length: 6,
                  showCursor: true,
                  controller: otpController,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: kPrimary
                      )
                    ),
                    textStyle: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  onSubmitted: (value){

                  },
                ),  
                SizedBox(height: 20.h,),
                CustomButton(text: "Xác nhận", onPressed: () async {
                      String smsCode = otpController.text.trim();
                      User? user = await _authService.verifyOtp(widget.verificationId, smsCode);
                      if (user != null) {
                        // Truyền UID sang màn hình đăng ký thông tin
                        Get.to(() => Inforegister(uid: user.uid, phoneNumber: widget.phoneNumber));
                      } else {
                        Get.snackbar("Lỗi", "Mã OTP không hợp lệ");
                      }
                    },backgroundColor: kPrimary, textColor: kWhite, fontSize: 22.sp, fontWeight: FontWeight.bold),
              ]            
          ),
        ),
       )
      ),
    );
  }
}