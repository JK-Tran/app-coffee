import 'dart:async';

import 'package:app_shopping/constants/Constants.dart';
import 'package:app_shopping/constants/enum/snackbar_type.dart';
import 'package:app_shopping/services/logger_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToast {
  static final _overlayEntry = ValueNotifier<OverlayEntry?>(null);
  static String? _lastMessage;
  static bool _isManuallyDismissed = false;
  static Timer? _removeToastTimer;  // Timer để quản lý việc tự động xóa

  static void show({
    required BuildContext context,
    required String title,
    required String message,
    required SnackbarType type,
    required Color backgroundColor,
    required Color textColor,
    double titleFontSize = 16,
    double messageFontSize = 14,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (_lastMessage == message) return;  // Không hiển thị lại cùng một thông báo
    _lastMessage = message;
    _isManuallyDismissed = false; // reset lại flag mỗi lần gọi show

    // Xóa Toast cũ nếu có
    _overlayEntry.value?.remove();
    _overlayEntry.value = null;

    final overlay = Overlay.of(context);

    final entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 20.h,
        left: 16.w,
        right: 16.w,
        child: _ToastWidget(
          title: title,
          message: message,
          backgroundColor: backgroundColor,
          textColor: textColor,
          titleFontSize: titleFontSize,
          messageFontSize: messageFontSize,
          type: type,
        ),
      ),
    );

    _overlayEntry.value = entry;
    overlay.insert(entry);

    // Hủy bỏ bất kỳ timer cũ nào để tránh hiển thị nhiều Toast
    _removeToastTimer?.cancel();
    _removeToastTimer = Timer(duration, () {
      // Chỉ xóa Toast nếu người dùng chưa vuốt để đóng
      if (_isManuallyDismissed) return;

      try {
        _overlayEntry.value?.remove();
        _overlayEntry.value = null;
        _lastMessage = null;
      } catch (e) {
        LoggerServices.error('❌ Error removing toast overlay: $e');
      }
    });
  }

  // Phương thức này được gọi khi Toast bị vuốt để báo là đã tự đóng
  static void dismissManually() {
    _isManuallyDismissed = true;
    // Hủy bỏ timer đang chạy
    _removeToastTimer?.cancel();
    // Xóa ngay OverlayEntry khi người dùng vuốt
    _overlayEntry.value?.remove();
    _overlayEntry.value = null;
    _lastMessage = null;
  }
}

class _ToastWidget extends StatefulWidget {
  final String title;
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final double titleFontSize;
  final double messageFontSize;
  final SnackbarType type; // Thêm loại để xác định biểu tượng

  const _ToastWidget({
    required this.title,
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.titleFontSize,
    required this.messageFontSize,
    required this.type,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isDismissing = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _slideAnimation = Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    IconData icon;
    Color iconColor;

    // Xác định biểu tượng tùy theo loại
    switch (widget.type) {
      case SnackbarType.success:
        icon = Icons.check_circle_outline;
        iconColor = kSuccess;
        break;
      case SnackbarType.error:
        icon = Icons.error_outline;
        iconColor = kError;
        break;
      case SnackbarType.warning:
        icon = Icons.warning_amber_outlined;
        iconColor = kWarning;
        break;
      case SnackbarType.info:
        icon = Icons.info_outline;
        iconColor = kInfo;
        break;
    }

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.up,
          onDismissed: (_) async {
            if (_isDismissing) return;
            setState(() => _isDismissing = true);
            CustomToast.dismissManually(); // Báo rằng Toast đã bị vuốt
            await _controller.reverse();
            if (mounted) {
              CustomToast._overlayEntry.value?.remove();
              CustomToast._overlayEntry.value = null;
              CustomToast._lastMessage = null;
            }
          },
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) => Opacity(
              opacity: _fadeAnimation.value,
              child: SlideTransition(
                position: _slideAnimation,
                child: child,
              ),
            ),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(12),
              color: widget.backgroundColor,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      icon,
                      color: iconColor,
                      size: 20.sp,
                    ),
                    SizedBox(width: 6.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: widget.titleFontSize.sp,
                            fontWeight: FontWeight.bold,
                            color: kDark,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          widget.message,
                          style: TextStyle(
                            fontSize: widget.messageFontSize.sp,
                            color: widget.textColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
