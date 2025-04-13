import 'package:app_shopping/constants/Constants.dart';
import 'package:app_shopping/screen/register_screen.dart';
import 'package:app_shopping/widgets/custom_text_field.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Country selectedCountry = Country(
    phoneCode: "84",
    countryCode: "VN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "Viet Nam",
    example: "Viet Nam",
    displayName: "Viet Nam",
    displayNameNoCountryCode: "VN",
    e164Key: "",
  );

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
                SizedBox(
                  height: 50.h,
                ),
                Image.asset(
                  'assets/images/logo_img.jpg',
                  height: 300.h,
                ),
                Text(
                  "Trải Nghiệm Theo Cách Riêng Của\nBạn",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kGray,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  controller: phoneController,
                  hintText: "",
                  keyboardType: TextInputType.phone,
                  prefixIcon: InkWell(
                    onTap: () {
                      showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme:
                              CountryListThemeData(bottomSheetHeight: 500),
                          onSelect: (Country country) {
                            setState(() {
                              selectedCountry = country;
                            });
                          });
                    },
                    child: Text(
                      "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: kDark,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),  
                 SizedBox( height: 20.h),
                CustomTextField(controller: passwordController, hintText: "Nhập mật khẩu", keyboardType: TextInputType.text,isPassword: true,),              
                SizedBox( height: 20.h),
                SizedBox(
                  width: double.infinity,
                  // Chiều rộng full màn hình
                  child: ElevatedButton(
                    onPressed: () async {
                     

                    
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      "Đăng nhập",
                      style: TextStyle(
                          color: kWhite,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Chưa có tài khoản?",
                      style: TextStyle(fontSize: 16.sp, color: kDark),
                    ),
                    SizedBox(width: 5.w),
                    InkWell(
                      onTap: (){
                        Get.off(RegisterScreen());
                      },child:Text(
                          "Đăng ký",                         
                          style: TextStyle(
                            color: kPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}