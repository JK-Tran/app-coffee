import 'package:app_shopping/constants/constants.dart';
import 'package:app_shopping/providers/register_provider.dart';
import 'package:app_shopping/screen/register_success_screen.dart';
import 'package:app_shopping/services/logger_services.dart';
import 'package:app_shopping/widgets/custom_button.dart';
import 'package:app_shopping/widgets/custom_text_field.dart';
import 'package:app_shopping/widgets/title_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class InforegisterScreen extends StatefulWidget {
  const InforegisterScreen({super.key});

  @override
  State<InforegisterScreen> createState() => _InforegisterScreenState();
}

class _InforegisterScreenState extends State<InforegisterScreen> {
  final TextEditingController firtName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController rePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context);
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
                  onPressed: () async {
                    final uid = provider.uid;
                    final phoneNumber = provider.phoneNumber; // nếu bạn đã lưu phoneNumber trong provider
                    final firstNameText = firtName.text.trim();
                    final lastNameText = lastName.text.trim();
                    final passwordText = password.text.trim();
                    final rePasswordText = rePassword.text.trim();

                    if (firstNameText.isEmpty || lastNameText.isEmpty || passwordText.isEmpty || rePasswordText.isEmpty) {
                      Get.snackbar("Thông báo", "Vui lòng nhập đầy đủ thông tin");
                      return;
                    }

                    if(passwordText != rePasswordText){
                      Get.snackbar("thông báo", "Mật khẩu không trùng khớp");
                    }

                    try{
                      final dio = Dio();
                      final response = await dio.post(
                        "$baseUrlRender/users/register",
                        data: {
                          "uid": uid,
                          "phoneNumber": phoneNumber,
                          "firstName": firstNameText,
                          "lastName": lastNameText,
                          "password":passwordText
                        }
                      );
                      if (response.statusCode == 201) {                      
                        Get.offAll(() => RegisterSuccessScreen());
                      } else {
                        Get.snackbar("Lỗi", "Đăng ký thất bại");
                      }
                    }catch(e){
                      Get.snackbar("Lỗi", "Có lỗi xảy ra");
                      LoggerServices.error("Lỗi xảy ra $e");
                    }
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
