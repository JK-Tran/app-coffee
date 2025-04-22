import 'package:app_shopping/constants/Constants.dart';
import 'package:app_shopping/providers/register_provider.dart';
import 'package:app_shopping/screen/login_screen.dart';

import 'package:app_shopping/view_models/register_view_model.dart';
import 'package:app_shopping/widgets/custom_button.dart';
import 'package:app_shopping/widgets/custom_text_field.dart';
import 'package:app_shopping/widgets/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            child: Form(
              key: _formKey,
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
                    hintText: "Nhập số điện thoại",
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
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.w),
                        child: Text(
                          "${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}",
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: kDark,
                              fontWeight: FontWeight.bold),
                        ),
                      ),               
                    ),
                    validator: (value){
                      if (value == null || value.trim().isEmpty) {
                        return "Vui lòng nhập số điện thoại";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    text: "Đăng ký",
                    onPressed: () async {
                      if(_formKey.currentState!.validate()){
                        LoadingOverlay.show(context);
                        final provider = Provider.of<RegisterProvider>(context, listen: false);
                        final viewModel = Provider.of<RegisterViewModel>(context,listen: false);

                        String phoneNumber = "+${selectedCountry.phoneCode}${phoneController.text.trim().replaceFirst("0", "")}";      

                        await viewModel.handleRegister(phoneNumber: phoneNumber, provider: provider, context: context);
                      }
                    },
                    backgroundColor: kPrimary,
                    textColor: kWhite,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Đã có tài khoản?",
                        style: TextStyle(fontSize: 16.sp, color: kDark),
                      ),
                      SizedBox(width: 5.w),
                      InkWell(
                        onTap: () {
                          Get.off(LoginScreen());
                        },
                        child: Text(
                          "Đăng nhập",
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
      ),
    );
  }
}
