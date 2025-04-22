import 'package:app_shopping/constants/Constants.dart';
import 'package:app_shopping/constants/enum/snackbar_type.dart';
import 'package:flutter/material.dart';

class NotificationService {
  // Hiển thị thông báo với các tùy chọn cơ bản
  static void showNotification({
    required BuildContext context,
    required String message,
    required SnackbarType type, // Kiểu thông báo: error, success, warning, info
    required String title, 
    required double fontsize,
    required Color color,
    Duration duration = const Duration(seconds: 2), // Thời gian hiển thị
  }) {
    // Hiển thị SnackBar với icon và thông báo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [       
                Text(
                  title,
                  style: TextStyle(
                    color: kDark, 
                    fontSize: 18,  // Cỡ chữ tiêu đề
                    fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 4),
              Text(
                message,
                style: TextStyle(
                  fontSize: fontsize,
                  color: color,
                ),  // Cỡ chữ thông báo
              ),
            ],
          ),
        ),
        backgroundColor: kWhite,
        dismissDirection: DismissDirection.up,
        behavior: SnackBarBehavior.floating, // Hiệu ứng nổi lên
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Bo góc
        duration: duration, // Thời gian hiển thị
        margin: EdgeInsets.only( left: 16, right: 16,bottom: MediaQuery.of(context).size.height - 120),// Đặt khoảng cách phía trên màn hình
      ),
    );
    
  }
}
