// import 'dart:io';

// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:permission_handler/permission_handler.dart';

// class FilePickerUtils {

//   Future<bool> checkAndRequestStoragePermissions() async {
  
//      if (Platform.isAndroid) {
//       DeviceInfoPlugin plugin = DeviceInfoPlugin();
//       AndroidDeviceInfo android = await plugin.androidInfo;
//       if (android.version.sdkInt >= 33) {
//         // var videosPermissionStatus = await Permission.videos.status;
//         var photoPermissionStatus = await Permission.photos.status;

//         if (photoPermissionStatus != PermissionStatus.granted) {
//           var permissionStatusPhoto = await Permission.photos.request();

//           if (permissionStatusPhoto.isGranted) {
//             return true;
//           } else if (permissionStatusPhoto.isPermanentlyDenied) {
//             galleryPermissionPermanentlyDenied = true;
//             return false;
//           } else {
//             return false;
//           }
//         } else if (photoPermissionStatus ==
//             PermissionStatus.permanentlyDenied) {
//           galleryPermissionPermanentlyDenied = true;
//           return false;
//         } else {
//           return true;
//         }
//       } else {
//         PermissionStatus permission = await Permission.storage.status;
//         if (permission != PermissionStatus.granted) {
//           var permissionStatus = await Permission.storage.request();
//           if (permissionStatus.isGranted) {
//             return true;
//           } else if (permissionStatus.isPermanentlyDenied) {
//             galleryPermissionPermanentlyDenied = true;
//             return false;
//           } else {
//             return false;
//           }
//         } else if (permission == PermissionStatus.permanentlyDenied) {
//           galleryPermissionPermanentlyDenied = true;
//           return false;
//         } else {
//           return true;
//         }
//       }
//     } else {
//       PermissionStatus permission = await Permission.photos.status;
//       if (permission != PermissionStatus.granted) {
//         var permissionStatus = await Permission.photos.request();
//         if (permissionStatus.isGranted) {
//           return true;
//         } else if (permissionStatus.isPermanentlyDenied) {
//           galleryPermissionPermanentlyDenied = true;
//           return false;
//         } else {
//           return false;
//         }
//       } else if (permission == PermissionStatus.permanentlyDenied) {
//         galleryPermissionPermanentlyDenied = true;
//         return false;
//       } else {
//         return true;
//       }
//     }
//   }

// }