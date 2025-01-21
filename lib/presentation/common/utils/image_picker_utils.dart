// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shift/domain/core/math_utils.dart';

import '../widgets/base_text.dart';

class ImagePickerUtils {
  final picker = ImagePicker();
  final int imageQuality = 50;
  bool cameraPermissionPermanentlyDenied = false;
  bool galleryPermissionPermanentlyDenied = false;

  Future<String?> pickImage(
      {required ImageSource imageSource, required BuildContext context}) async {
    try {
      XFile? pickedImage;

      if (imageSource == ImageSource.gallery) {
        var permission = await checkAndRequestStoragePermissions();
        print("Storage permission ---> $permission");
        print(permission);
        if (permission) {
          pickedImage = await picker.pickImage(
            source: imageSource,
            // maxWidth: imageMaxWidth,
            // maxHeight: imageMaxHeight,
            imageQuality: imageQuality,
          );
        } else {
          if (galleryPermissionPermanentlyDenied) {
            _showPermissionAlertDialog(
              imageSource: imageSource,
              context: context,
            );
          }
        }
      } else if (imageSource == ImageSource.camera) {
        try {
          var permission = await checkAndRequestCameraPermissions();
          print("permission---> $permission");
          if (permission) {
            /*    pickedImage = await picker.pickImage(
              source: imageSource,
              // maxWidth: imageMaxWidth,
              // maxHeight: imageMaxHeight,
              // imageQuality: 10,
            ); */
            pickedImage = await picker.pickImage(
              source: imageSource,
              maxWidth: 1080,
              maxHeight: 1920,
              imageQuality: 50,
            );
          } else {
            if (cameraPermissionPermanentlyDenied) {
              _showPermissionAlertDialog(
                  imageSource: imageSource, context: context);
            }
          }
        } catch (e, stackTrace) {
          print("Error crash imagepicker ---> $e");
          print("Stack trace: $stackTrace");
        }
      }

      if (pickedImage != null) {
        //profileImagePath.value = pickedImage.path;
        //UserMoreInfo.userInfoModel.document = profileImagePath.value;

        File imageFile = File(pickedImage.path);

        print('File path = ${pickedImage.path}');
        print(
            'File size = ${(imageFile.lengthSync() / 1024).toStringAsFixed(2)} KB');
      } else {
        print('picked image is $pickedImage');
      }

      return pickedImage?.path;
    } catch (ex) {
      print('Pick image catch Error ===> ${ex.toString()}');
      return null;
    }
  }

  Future<bool> checkAndRequestCameraPermissions() async {
    PermissionStatus permission = await Permission.camera.status;

    if (permission != PermissionStatus.granted) {
      var permissionStatus = await Permission.camera.request();
      if (permissionStatus.isGranted) {
        return true;
      } else if (permissionStatus.isPermanentlyDenied) {
        cameraPermissionPermanentlyDenied = true;
        return false;
      } else {
        return false;
      }
    } else if (permission == PermissionStatus.permanentlyDenied) {
      cameraPermissionPermanentlyDenied = true;
      return false;
    } else {
      return true;
    }
  }

  Future<bool> checkAndRequestStoragePermissions() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt >= 33) {
        // var videosPermissionStatus = await Permission.videos.status;
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

      if (permission != PermissionStatus.granted &&
          permission != PermissionStatus.limited) {
        print("Permission Status---> $permission");

        var permissionStatus = await Permission.photos.request();
        if (permissionStatus.isGranted ||
            permission != PermissionStatus.limited) {
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
      {required ImageSource imageSource, required BuildContext context}) async {
    return Future.delayed(const Duration(seconds: 1), () {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
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
            title: const BaseText(
              text: 'Permission Denied!',
              fontWeight: FontWeight.w600,
            ),
            content: imageSource == ImageSource.gallery
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: Platform.isIOS
                            ? 'Unable to access Photos. Grant access by going to Settings > ShiftFinder > Photos, then select the access level and try again:'
                            : 'Unable to access Gallery. Grant access by going to Settings > Apps > ShiftFinder > Permissions, then allow access to Storage and try again:',
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
                            text: Platform.isIOS ? 'Photos' : 'Storage',
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: Platform.isIOS
                            ? 'Unable to access Camera. Grant access by going to Settings > ShiftFinder> Camera, then allow access to Camera and try again: '
                            : 'Unable to access Camera. Grant access by going to Settings > Apps > ShiftFinder> Permissions, then allow access to Camera and try again:',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: getSize(20),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.camera_alt_outlined),
                          SizedBox(
                            width: getSize(10),
                          ),
                          const BaseText(
                            text: 'Camera',
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
            actions: <Widget>[
              TextButton(
                child: const BaseText(
                  text: 'Cancel',
                  fontWeight: FontWeight.w600,
                  textColor: Colors.blueAccent,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const BaseText(
                  text: 'Open Settings',
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
