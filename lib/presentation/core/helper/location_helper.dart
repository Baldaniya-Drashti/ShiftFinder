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
