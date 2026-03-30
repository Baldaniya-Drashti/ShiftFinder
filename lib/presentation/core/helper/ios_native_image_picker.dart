/* import 'package:flutter/services.dart';

class IosNativeImagePicker {
  static const MethodChannel _channel =
      MethodChannel('bs_image_picker_channel');

  Future<String?> openImagePicker() async {
    try {
      final String? result = await _channel.invokeMethod('openImagePicker');
      print("Result: ${result.toString()}");
      return result;
    } on PlatformException catch (e) {
      print("Error: ${e.message}");
      return null;
    }
  }
}
 */
