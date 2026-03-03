import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NetworkNotifier extends Notifier<ConnectivityResult> {
  late final Connectivity _connectivity;

  @override
  ConnectivityResult build() {
    _connectivity = Connectivity();

    _connectivity.onConnectivityChanged.listen((result) {
      state = result.first;
    });

    return ConnectivityResult.none;
  }
}
