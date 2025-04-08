import 'package:app_shopping/constants/constants.dart';
import 'package:app_shopping/screen/home/home_screen.dart';
import 'package:app_shopping/screen/register_success_screen.dart';
import 'package:app_shopping/widgets/custom_button.dart';
import 'package:app_shopping/widgets/custom_text_field.dart';
import 'package:app_shopping/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Inforegister extends StatefulWidget {
  final String uid;
  final String phoneNumber;
  const Inforegister({super.key, required this.uid, required this.phoneNumber});

  @override
  State<Inforegister> createState() => _InforegisterState();
}

class _InforegisterState extends State<Inforegister> {
  final TextEditingController firtName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                ), //
                TitleText(
                    title: "Thông tin đăng ký",
                    color: kDark,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 10.h,
                ), //
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                          controller: lastName,
                          hintText: "Họ",
                          keyboardType: TextInputType.text),
                    ),
                    SizedBox(width: 10.w), // Khoảng cách giữa 2 ô nhập
                    Expanded(
                      child: CustomTextField(
                          controller: firtName,
                          hintText: "Tên",
                          keyboardType: TextInputType.text),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                    controller: password,
                    hintText: "Mật khẩu",
                    isPassword: true,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 20.h,
                ),
                CustomTextField(
                    controller: rePassword,
                    hintText: "Nhập lại mật khẩu",
                    isPassword: true,
                    keyboardType: TextInputType.text),
                SizedBox(
                  height: 30.h,
                ),
                CustomButton(
                  text: "Hoàn tất",
                  onPressed: () {
                    Get.off(
                      () => RegisterSuccessScreen(),
                      transition: Transition.cupertino,
                      duration: Duration(milliseconds: 600),
                    );

                    Future.delayed(Duration(seconds: 3), () {
                      Get.off(
                        () => HomeScreen(),
                        transition: Transition.rightToLeft, // Hiệu ứng fade nhẹ hơn
                        duration: Duration(milliseconds: 600),
                      );
                    });
                  },
                  textColor: kWhite,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  backgroundColor: kPrimary,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
