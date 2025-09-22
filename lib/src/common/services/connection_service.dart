import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

abstract interface class ConnectionService {
  bool get isConnected;
  Future<void> checkConnection();
}

class ConnectionServiceImpl implements ConnectionService {
  final Connectivity _connectivity = Connectivity();

  bool _isConnected = false;

  @override
  bool get isConnected => _isConnected;

  @override
  Future<void> checkConnection() async {
    try {
      final List<ConnectivityResult> result = await _connectivity
          .checkConnectivity();
      final bool hasConnection = !result.contains(ConnectivityResult.none);

      _isConnected = hasConnection;
      debugPrint('Connected? $hasConnection');
    } catch (error) {
      throw Exception('ConnectionService: $error');
    }
  }
}
