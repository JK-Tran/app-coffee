import 'package:app_shopping/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_indicator/loading_indicator.dart';


class LoadingOverlay {
  static void show (BuildContext context){
    showDialog(
      context: context, 
      barrierDismissible: false,
      builder: (_) => Center(
        child: SizedBox(
          width: 60.w,
          height: 60.h,
          child: LoadingIndicator(
            indicatorType: Indicator.ballSpinFadeLoader,
            colors: [kPrimary],
            strokeWidth: 1,
          )
        ),
      )
    );
  }

  static void hide(BuildContext context){
    Navigator.of(context, rootNavigator: true).pop();
  }
}