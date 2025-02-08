import 'package:flutter/cupertino.dart';
import 'package:novocinema/core/utils/ListnerUtils.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  BuildContext context;

  PermissionService(this.context);

  Future<void> requestLocationPermission(Function onPermissionGranted) async {
    const cameraPermission = Permission.location;
    final status = await cameraPermission.status;

    if (await cameraPermission.isDenied) {
      final result = await cameraPermission.request();
      if (result.isGranted) {
        onPermissionGranted();
        ListnersUtils.showSuccessMessage( result.toString(), status.toString(), context);
      } else if (result.isDenied) {
        ListnersUtils.showErrorMessage(result.toString(), status.toString(), context);
      } else if (result.isPermanentlyDenied) {
        await openAppSettings();
        ListnersUtils.showErrorMessage( result.toString(), status.toString(), context);
      } else {
        ListnersUtils.showErrorMessage(result.toString(), status.toString(), context);
      }
    }
  }
}
