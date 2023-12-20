import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:gshopp_flutter/utils/tools/helper_fuctions.dart';

class NetworkManager extends GetxController {
  static final NetworkManager _instance = NetworkManager._internal();

  // Getter for the singleton instance
  static NetworkManager get instance => _instance;

  NetworkManager._internal();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      AnimatedSnackBar.material(
        'This a snackbar with info type',
        type: AnimatedSnackBarType.error,
      ).show(HelperFunctions.currentContext!);
    }
  }

  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}
