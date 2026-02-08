import 'dart:async';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InternetService {
  InternetService() {
    _init();
  }
  final StreamController<bool> _controller = StreamController<bool>.broadcast();
  bool _isConnected = true;

  bool get isConnected => _isConnected;
  Stream<bool> get onStatusChanged => _controller.stream;
  final InternetConnection _internetConnection = InternetConnection();

  void _init() {
    _startMonitoring();
  }

  void _startMonitoring() {
    _internetConnection.onStatusChange.listen((event) {
      final hasInternet = event == InternetStatus.connected;
      _setConnection(hasInternet);
    });
  }

  void _setConnection(bool status) {
    if (_isConnected != status) {
      _isConnected = status;
      _controller.add(status);
    }
  }

  void dispose() => _controller.close();
}
