import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_shopping/constants/constants.dart'; // Đảm bảo đã khai báo kPrimary và kWhite

class RegisterSuccessScreen extends StatelessWidget {
  const RegisterSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(   
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 150.sp,
                  color: Colors.green,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Đăng ký thành công",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: kDark,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Hãy đăng nhập và khám phá thế giới cà phê đầy cảm hứng ngay hôm nay.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: kDark,
                  ),
                ),            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
