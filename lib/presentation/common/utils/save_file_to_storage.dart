import 'dart:io';
import 'dart:typed_data';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveFileToStorage {
  static Future<String?> savePdfToShiftFinderDirectory(Uint8List pdfData,
      {required String fileName}) async {
    try {
      if (Platform.isAndroid) {
        DeviceInfoPlugin plugin = DeviceInfoPlugin();
        AndroidDeviceInfo android = await plugin.androidInfo;
        if (await Permission.storage.isGranted ||
            await Permission.mediaLibrary.isGranted) {
          print('Storage permission already granted.');
        }

        if (android.version.sdkInt >= 33) {
          final photos = await Permission.photos.request();
          final videos = await Permission.videos.request();
          final audio = await Permission.audio.request();

          if (photos.isGranted || videos.isGranted || audio.isGranted) {
            print('Media permissions granted!');
          } else {
            return 'Photos Videos Audio permission denied.';
          }
        } else if (android.version.sdkInt >= 30) {
          final status = await Permission.manageExternalStorage.request();
          if (!status.isGranted) {
            return 'External Storage permission denied.';
          }
        } else {
          final status = await Permission.storage.request();
          if (!status.isGranted) {
            return 'Storage permission denied.';
          }
        }
      }

      // Get the Downloads directory
      Directory? downloadsDir;
      if (Platform.isAndroid) {
        downloadsDir = Directory('/storage/emulated/0/Download');
      } else if (Platform.isIOS) {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      if (downloadsDir == null) {
        return 'Could not find Downloads directory.';
      }

      // Create "ShiftFinder" directory inside Downloads
      final shiftFinderDir = Directory('${downloadsDir.path}/ShiftFinder');
      if (!shiftFinderDir.existsSync()) {
        shiftFinderDir.createSync(recursive: true);
      }

      // Save the PDF file in the "ShiftFinder" directory
      final pdfPath = '${shiftFinderDir.path}/$fileName';
      final file = File(pdfPath);
      await file.writeAsBytes(pdfData);

      return pdfPath; // Return the file path
    } catch (e) {
      return 'Error saving PDF: $e';
    }
  }
}
