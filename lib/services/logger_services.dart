import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerServices {
  static final Logger _logger = Logger(
      level: kReleaseMode ? Level.off : Level.debug,
      printer: PrettyPrinter(
        methodCount: 0,
        errorMethodCount: 3,
        lineLength: 80,
        colors: true,
        printEmojis: true,
        dateTimeFormat: kReleaseMode
          ? DateTimeFormat.none
          : DateTimeFormat.onlyTimeAndSinceStart, // ✅ sửa printTime
      )
    );

  static void debug(dynamic message) {
    _logger.d(message);
  }

  static void info(dynamic message) {
    _logger.i(message);
  }

  static void warning(dynamic message) {
    _logger.w(message);
  }

  static void error(dynamic message) {
    _logger.e(message);
  }
}
