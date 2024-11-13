import 'dart:developer';

import 'package:flutter/foundation.dart';

final class LoggerApp {
  LoggerApp._();
  static void app(String message) => _log(message, LogLevel.app);

  static void debug(String message) => _log(message, LogLevel.debug);

  static void info(String message) => _log(message, LogLevel.info);

  static void error(String message, [dynamic error, StackTrace? stackTrace]) =>
      _log(message, LogLevel.error, error, stackTrace);

  static void success(String message) => _log(message, LogLevel.success);

  static void _log(
    String message,
    LogLevel level, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    final levelName = level.toString().split('.').last.toUpperCase();

    String fullMessage = '${level.color} [$levelName] $message\x1B[0m';
    if (error != null) {
      fullMessage += '\n\n${level.color} ERROR => $error\x1B[0m';
    }
    if (stackTrace != null) {
      fullMessage += '\n\n${level.color} STACKTRACE => $stackTrace\x1B[0m';
    }

    if (kDebugMode) {
      log(
        fullMessage,
        name: 'LINUTRI',
        level: level.index,
      );
    }
  }
}

enum LogLevel {
  app,
  debug,
  info,
  error,
  success;

  String get black => '\x1B[30m';
  String get red => '\x1B[31m';
  String get green => '\x1B[32m';
  String get yellow => '\x1B[33m';
  String get blue => '\x1B[34m';
  String get magenta => '\x1B[35m';
  String get cyan => '\x1B[36m';
  String get white => '\x1B[37m';

  String get color => switch (this) {
        app => '$white⚙️',
        debug => '$yellow➤',
        info => '$blue♢',
        error => '$red✖︎',
        success => '$green✓',
      };
}
