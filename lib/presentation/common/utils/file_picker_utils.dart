// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';

class FilePickerUtils {
  bool galleryPermissionPermanentlyDenied = false;

  Future<String?> pickPdf({required BuildContext context}) async {
    try {
      var permission = await checkAndRequestStoragePermissions();
      if (permission) {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );

        if (result != null) {
          String? filePath = result.files.single.path;
          print('File path = $filePath');
          return filePath;
        }
      } else {
        if (galleryPermissionPermanentlyDenied) {
          _showPermissionAlertDialog(context: context);
        }
      }
    } catch (ex) {
      print('Error ===> ${ex.toString()}');
    }
    return null;
  }

  Future<bool> checkAndRequestStoragePermissions() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt >= 33) {
        var photoPermissionStatus = await Permission.photos.status;

        if (photoPermissionStatus != PermissionStatus.granted) {
          var permissionStatusPhoto = await Permission.photos.request();

          if (permissionStatusPhoto.isGranted) {
            return true;
          } else if (permissionStatusPhoto.isPermanentlyDenied) {
            galleryPermissionPermanentlyDenied = true;
            return false;
          } else {
            return false;
          }
        } else if (photoPermissionStatus ==
            PermissionStatus.permanentlyDenied) {
          galleryPermissionPermanentlyDenied = true;
          return false;
        } else {
          return true;
        }
      } else {
        PermissionStatus permission = await Permission.storage.status;
        if (permission != PermissionStatus.granted) {
          var permissionStatus = await Permission.storage.request();
          if (permissionStatus.isGranted) {
            return true;
          } else if (permissionStatus.isPermanentlyDenied) {
            galleryPermissionPermanentlyDenied = true;
            return false;
          } else {
            return false;
          }
        } else if (permission == PermissionStatus.permanentlyDenied) {
          galleryPermissionPermanentlyDenied = true;
          return false;
        } else {
          return true;
        }
      }
    } else {
      PermissionStatus permission = await Permission.photos.status;
      if (permission != PermissionStatus.granted) {
        var permissionStatus = await Permission.photos.request();
        if (permissionStatus.isGranted) {
          return true;
        } else if (permissionStatus.isPermanentlyDenied) {
          galleryPermissionPermanentlyDenied = true;
          return false;
        } else {
          return false;
        }
      } else if (permission == PermissionStatus.permanentlyDenied) {
        galleryPermissionPermanentlyDenied = true;
        return false;
      } else {
        return true;
      }
    }
  }

  Future<void> _showPermissionAlertDialog(
      {required BuildContext context}) async {
    return Future.delayed(const Duration(seconds: 1), () {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: SmoothRectangleBorder(
              borderRadius: SmoothBorderRadius.all(
                SmoothRadius(
                  cornerRadius: getSize(20),
                  cornerSmoothing: 1,
                ),
              ),
            ),
            title: BaseText(
              text: StringConstant.permissionDenied,
              fontWeight: FontWeight.w600,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BaseText(
                  text: Platform.isIOS
                      ? 'Unable to access Photos. Grant access by going to Settings > ShiftFinder > Photos, then select the access level and try again:'
                      : 'Unable to access Files. Grant access by going to Settings > Apps > Shift Finder > Permissions, then allow access to Storage and try again:',
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: getSize(20),
                ),
                Row(
                  children: [
                    const Icon(Icons.photo),
                    SizedBox(
                      width: getSize(10),
                    ),
                    BaseText(
                      text: Platform.isIOS
                          ? StringConstant.photos
                          : StringConstant.storage,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: BaseText(
                  text: StringConstant.cancle,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: BaseText(
                  text: StringConstant.openSettings,
                  fontWeight: FontWeight.w600,
                  textColor: Colors.blueAccent,
                ),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }
}
