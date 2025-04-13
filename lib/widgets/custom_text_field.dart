import 'package:app_shopping/constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final InkWell? prefixIcon;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.isPassword = false,
      required this.keyboardType,
      this.prefixIcon});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscure = true; // biến ẩn hiển
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _isObscure : false,
      cursorColor: kPrimary,
      decoration: InputDecoration(
       contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
        hintText: widget.hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kGray),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: kPrimary, width: 2.0),
        ),
      prefixIcon: widget.prefixIcon != null
        ? SizedBox(
          width: 80.w,
          height: 50.w,
          child: Align(
            alignment: Alignment.center,
            child: widget.prefixIcon,
          ),
        )
        : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  size: 18.sp,
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: kDark,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
