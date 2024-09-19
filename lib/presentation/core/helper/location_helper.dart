// // ignore_for_file: use_build_context_synchronously

// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:grape_customer_app/domain/core/math_utils.dart';
// import 'package:grape_customer_app/presentation/common/widgets/base_text.dart';

// class LocationHelper {
//   String? currentLocation;
//   var locationDontAllow = false;
//   double? latitude;
//   double? longitude;
//   Future<(String?, double?, double?)> getCurrentLocation() async {
//     LocationPermission askedPermission;
//     askedPermission = await Geolocator.requestPermission();
//     if (askedPermission == LocationPermission.always ||
//         askedPermission == LocationPermission.whileInUse) {
//       Position currentPosition = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.best);

//       await getAddressFromLatLng(currentPosition);

//       latitude = currentPosition.latitude;
//       longitude = currentPosition.longitude;

//       return (currentLocation ?? '', latitude, longitude);
//     } else if (askedPermission == LocationPermission.denied) {
//       askedPermission = await Geolocator.requestPermission();
//     } else if (askedPermission == LocationPermission.deniedForever) {
//       locationDontAllow = true;
//       //showPermissionAlertDialog();
//     }
//     return (currentLocation ?? '', latitude, longitude);
//   }

//   Future<void> getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(position.latitude, position.longitude)
//         .then((placeMark) {
//       Placemark place = placeMark[0];
//       log('Currenct Location : ${place.toJson()}');
//       currentLocation =
//           "${place.street!},${place.subLocality!},${place.locality},${place.administrativeArea},${place.country},${place.postalCode} ";
//       // '${place.subLocality},${place.locality},${place.administrativeArea},${place.country},${place.postalCode}';
//     }).catchError((e) {
//       // CommonWidget.toast(e);
//     });
//   }

//   showPermissionAlertDialog(BuildContext context) async {
//     //  return Container();
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           // shape: SmoothRectangleBorder(
//           //   borderRadius: SmoothBorderRadius.all(
//           //     SmoothRadius(
//           //       cornerRadius: getSize(20),
//           //       cornerSmoothing: 1,
//           //     ),
//           //   ),
//           // ),
//           title: BaseText(
//             text: 'Permission Denied!',
//             fontWeight: FontWeight.w600,
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               BaseText(
//                   text:
//                       'Unable to get location. Go to Settings > Permissions, then allow following permissions and try again:'),
//               SizedBox(
//                 height: getSize(20),
//               ),
//               Row(
//                 children: [
//                   Icon(Icons.location_disabled),
//                   SizedBox(
//                     width: getSize(10),
//                   ),
//                   BaseText(
//                     text: 'Location',
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: BaseText(
//                 text: 'Cancel',
//                 fontWeight: FontWeight.w600,
//                 textColor: Colors.blueAccent,
//               ),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: BaseText(
//                 text: 'Open Settings',
//                 fontWeight: FontWeight.w600,
//                 textColor: Colors.blueAccent,
//               ),
//               onPressed: () {
//                 Geolocator.openLocationSettings();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';

class LocationHelper {
  /// TO GET GOOGLE PLACES
  static Future<String?> fetchUrl(String query,
      {Map<String, String>? headers}) async {
    var apiKey = dotenv.env['GOOGLE_PLACE_API_KEY'];
    var uri = Uri.tryParse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=address&language=en&components=country:ca&key=$apiKey")!;

    try {
      final response = await http.get(
        uri,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("LOCATION CATCH ERROR: $e");
    }
    return null;
  }

  /*Future<String?> fetchUrl(String query, {Map<String, String>? headers}) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": "AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
        "components": "country:ca",
      },
    );
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("LOCATION CATCH ERROR: $e");
    }
    return null;
  }*/

  static Future<PlaceDetailDTO?> getPlaceDetail(String placeId) async {
    var apiKey = dotenv.env['GOOGLE_PLACE_API_KEY'];
    var uri = Uri.tryParse(
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry&key=$apiKey"
        //   "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&types=address&language=en&components=country:ca&key=AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
        )!;
    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        var placeDetail = PlaceDetailDTO.fromJson(data);

        return placeDetail;
        // setState(() {
        //   placeName = result['name'];
        //   rating = result['rating'];
        //   phoneNumber = result['formatted_phone_number'];
        // });
      } else {
        print('Failed to load place details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }
}
