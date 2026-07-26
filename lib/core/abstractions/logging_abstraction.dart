import 'dart:async';
import 'dart:developer' as devtools;

import 'package:logging/logging.dart';

typedef LogRecordHandler = void Function(LogRecord record);

/// Central logging entrypoint for the app.
///
/// Logs are routed to `dart:developer` so they are visible in DevTools
/// logging view and are not emitted through console `print/debugPrint`.
final class LoggingAbstraction {
  LoggingAbstraction._();

  static final LoggingAbstraction instance = LoggingAbstraction._();

  StreamSubscription<LogRecord>? _rootSubscription;

  bool get isInitialized => _rootSubscription != null;

  StreamSubscription<LogRecord> initializeLogging({
    Level rootLevel = Level.ALL,
    List<LogRecordHandler> onLogs = const [],
    bool reinitialize = false,
  }) {
    if (_rootSubscription != null && !reinitialize) {
      return _rootSubscription!;
    }

    _rootSubscription?.cancel();
    Logger.root.level = rootLevel;

    _rootSubscription = Logger.root.onRecord.listen((record) {
      _forwardToDevTools(record);
      for (final onLog in onLogs) {
        onLog(record);
      }
    });

    return _rootSubscription!;
  }

  Future<void> dispose() async {
    await _rootSubscription?.cancel();
    _rootSubscription = null;
  }

  void success(
    Object? message, {
    String loggerName = 'App',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.CONFIG,
      message,
      loggerName: loggerName,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void debug(
    Object? message, {
    String loggerName = 'App',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.FINE,
      message,
      loggerName: loggerName,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void info(
    Object? message, {
    String loggerName = 'App',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.INFO,
      message,
      loggerName: loggerName,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void warning(
    Object? message, {
    String loggerName = 'App',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.WARNING,
      message,
      loggerName: loggerName,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void error(
    Object? message, {
    String loggerName = 'App',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.SEVERE,
      message,
      loggerName: loggerName,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void shout(
    Object? message, {
    String loggerName = 'App',
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.SHOUT,
      message,
      loggerName: loggerName,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _log( 
    Level level,
    Object? message, {
    required String loggerName,
    Object? error,
    StackTrace? stackTrace,
  }) {
    Logger(loggerName).log(
      level,
      message?.toString() ?? 'null',
      error,
      stackTrace,
    );
  }

  void _forwardToDevTools(LogRecord record) {
    devtools.log(
      record.message,
      name: record.loggerName,
      level: _toDeveloperLevel(record.level),
      time: record.time,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  }

  int _toDeveloperLevel(Level level) {
    if (level >= Level.SHOUT) return 2000;
    if (level >= Level.SEVERE) return 1200;
    if (level >= Level.WARNING) return 900;
    if (level >= Level.INFO) return 800;
    if (level >= Level.CONFIG) return 700;
    return 500;
  }
}
