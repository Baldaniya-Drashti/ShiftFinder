import UIKit
import Flutter
import GoogleMaps
import FirebaseCore
/*  import BSImagePicker
 import Photos */

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyDy4ZbZH0qMiRicZwKvu0PjehSZdofIY48")
    GeneratedPluginRegistrant.register(with: self)

    // Set up a method channel for BSImagePicker
    /*if let controller = window?.rootViewController as? FlutterViewController {
      let imagePickerChannel = FlutterMethodChannel(name: "bs_image_picker_channel",
                                                    binaryMessenger: controller.binaryMessenger)
      imagePickerChannel.setMethodCallHandler { [weak self] (call, result) in
        if call.method == "openImagePicker" {
          self?.openImagePicker(result: result, viewController: controller)
        } else {
          result(FlutterMethodNotImplemented)
        }
      }
    }*/

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

// Function to handle BSImagePicker logic

  /*private func openImagePicker(result: @escaping FlutterResult, viewController: UIViewController) {
    let imagePicker = ImagePickerController()
    imagePicker.settings.selection.max = 1 // Allow only single image selection
    imagePicker.settings.fetch.assets.supportedMediaTypes = [.image,]
    viewController.presentImagePicker(imagePicker, select: { (asset) in
    print("Asset selected: \(asset)")
        // User selected an asset.
    }, deselect: { (asset) in
    print("Asset deselected: \(asset)")
        // User deselected an asset.
    }, cancel: { (assets) in
    print("Selection canceled")
        // User canceled selection.
        result(nil)
    }, finish: { (assets) in
    print("Selection finished")
        // User finished selection.
        if let asset = assets.first {
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { (image, info) in
                if let image = image {
                    let tempDir = FileManager.default.temporaryDirectory
                    let imageName = UUID().uuidString + ".jpg"
                    let imagePath = tempDir.appendingPathComponent(imageName).path

                    if let imageData = image.jpegData(compressionQuality: 0.8) {
                        do {
                            try imageData.write(to: URL(fileURLWithPath: imagePath))
                            result(imagePath)
                        } catch {
                            print("Error saving image to disk")
                            result(nil)
                        }
                    } else {
                        result(nil)
                    }
                } else {
                    result(nil)
                }
            }
        } else {
            result(nil)
        }
    })
  }*/
}

