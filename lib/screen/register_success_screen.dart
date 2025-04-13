import 'package:app_shopping/screen/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:app_shopping/constants/Constants.dart';
import 'package:get/get.dart'; // Đảm bảo đã khai báo kPrimary và kWhite

class RegisterSuccessScreen extends StatefulWidget {
  const RegisterSuccessScreen({super.key});

  @override
  State<RegisterSuccessScreen> createState() => _RegisterSuccessScreenState();
}

class _RegisterSuccessScreenState extends State<RegisterSuccessScreen> {

  @override
  void initState() {
  super.initState();
    // Chờ 2 giây rồi chuyển sang HomeScreen
    Future.delayed(Duration(seconds: 3), () {
      Get.offAll(() => HomeScreen(),transition: Transition.rightToLeft,duration: Duration(milliseconds: 800));
    });
  }

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
