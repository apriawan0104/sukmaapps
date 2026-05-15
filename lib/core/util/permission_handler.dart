// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';

// Future<bool> checkPermission() async {
//   try {
//     Map<Permission, PermissionStatus> statues = await [Permission.camera].request();
//     PermissionStatus? statusCamera = statues[Permission.camera];
//     bool isGranted = statusCamera == PermissionStatus.granted;
//     if (isGranted) {
//       return true;
//     }
//     bool isPermanentlyDenied = statusCamera == PermissionStatus.permanentlyDenied;
//     if (isPermanentlyDenied) {
//       // Handle permanently denied case
//     }
//     return false;
//   } catch (e) {
//     print('Permission check error: $e');
//     return false;
//   }
// }

// Future<bool> checkPermissionMedia({required ImageSource imageSource}) async {
//   try {
//     if (imageSource == ImageSource.camera) {
//       Map<Permission, PermissionStatus> statues = await [Permission.camera].request();
//       PermissionStatus? statusCamera = statues[Permission.camera];
//       bool isGranted = statusCamera == PermissionStatus.granted;
//       if (isGranted) {
//         return true;
//       }
//       bool isPermanentlyDenied = statusCamera == PermissionStatus.permanentlyDenied;
//       if (isPermanentlyDenied) {
//         openAppSettings();
//       }
//       return false;
//     } else {
//       // For gallery access, we don't need explicit permission in Android 13+
//       // The image_picker will handle the permission automatically
//       return true;
//     }
//   } catch (e) {
//     print('Permission media check error: $e');
//     return false;
//   }
// }
