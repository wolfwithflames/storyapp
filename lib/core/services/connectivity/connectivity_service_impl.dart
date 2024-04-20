import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:logging/logging.dart';
import 'package:storyapp/core/data/enums.dart';
import 'package:storyapp/core/services/connectivity/connectivity_service.dart';

class ConnectivityServiceImpl implements ConnectivityService {
  final _log = Logger('ConnectivityServiceImpl');

  final _connectivityResultController = StreamController<ConnectivityStatus>();
  final _connectivity = Connectivity();

  late StreamSubscription<List<ConnectivityResult>> _subscription;
  ConnectivityResult? _lastResult;
  bool _serviceStopped = false;

  @override
  Stream<ConnectivityStatus> get connectivity$ =>
      _connectivityResultController.stream;

  @override
  bool get serviceStopped => _serviceStopped;

  ConnectivityServiceImpl() {
    _subscription =
        _connectivity.onConnectivityChanged.listen(_emitConnectivity);
  }

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    if (result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi)) {
      return true;
    }
    if (result.contains(ConnectivityResult.none)) {
      return false;
    }
    return false;
  }

  @override
  void start() async {
    _log.finer('ConnectivityService resumed');
    _serviceStopped = false;

    await _resumeSignal();
    _subscription.resume();
  }

  @override
  void stop() {
    _log.finer('ConnectivityService paused');
    _serviceStopped = true;

    _subscription.pause(_resumeSignal());
  }

  void _emitConnectivity(List<ConnectivityResult> event) {
    if (event == _lastResult) return;

    _log.finer('Connectivity status changed to $event');
    _connectivityResultController.add(_convertResult(event));
    if (event.isNotEmpty) {
      _lastResult = event.first;
    }
  }

  ConnectivityStatus _convertResult(List<ConnectivityResult> result) {
    if (result.isEmpty) {
      return ConnectivityStatus.offline;
    }
    switch (result.first) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.cellular;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.wiFi;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      default:
        return ConnectivityStatus.offline;
    }
  }

  Future<void> _resumeSignal() async => true;
}
