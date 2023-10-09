import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_app/widgets/custom_error.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionState);
  }

  void _updateConnectionState(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      Get.dialog(
        const CustomError(
          icon: Icons.wifi_off, 
          errorMessage: 'PLEASE CONNECT TO THE INTERNET',
        ),
        barrierDismissible: false,
      );
    } else {
      if (Get.isDialogOpen!) {
        Get.back();
      }
    }
  }
}
