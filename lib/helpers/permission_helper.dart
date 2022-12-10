import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<PermissionStatus> getLocationPermissionStatus() async {
    return await Permission.location.status;
  }
  static Future<void> askLocationPermission() async {
    Permission.location.request();
  }
}