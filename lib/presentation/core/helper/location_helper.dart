import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/infrastructure/core/location_dto/search_location_dto/place_detail_dto.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:url_launcher/url_launcher.dart';

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
      } else {
        print('Failed to load place details: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    }
    return null;
  }

  static Future<Location?> getLocationDetailsFromLatLng(
      double? lat, double? lng) async {
    final apiKey = dotenv.env['GOOGLE_PLACE_API_KEY'];
    // Example API endpoint or geocoding service
    // final response = await http.get(Uri.parse('https://geocoding.api.com?lat=$lat&lng=$lng'));
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey'));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      var addressComponents = data['results'][0]['address_components'];
      String? city, state, postalCode;

      for (var component in addressComponents) {
        if (component['types'].contains('locality')) {
          city = component['long_name'];
        } else if (component['types'].contains('administrative_area_level_1')) {
          state = component['long_name'];
        } else if (component['types'].contains('postal_code')) {
          postalCode = component['long_name'];
        }
      }

      return Location(
        lat: lat,
        lng: lng,
        city: city,
        state: state,
        postalCode: postalCode,
      );
    }
    return null;
  }

  static Future<(Position?, double?, double?)> getCurrentLocation(
      BuildContext context) async {
    Position? currentPosition;
    // ignore: unused_local_variable
    bool locationDontAllow = false;
    double? currentLat;
    double? currentLng;
    LocationPermission askedPermission;
    askedPermission = await Geolocator.requestPermission();
    if (askedPermission == LocationPermission.always ||
        askedPermission == LocationPermission.whileInUse) {
      currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      currentLat = currentPosition.latitude;
      currentLng = currentPosition.longitude;

      return (currentPosition, currentLat, currentLng);
    } else if (askedPermission == LocationPermission.denied) {
      askedPermission = await Geolocator.requestPermission();
    } else if (askedPermission == LocationPermission.deniedForever) {
      locationDontAllow = true;
      showPermissionAlertDialog(context);
    }
    return (currentPosition, currentLat, currentLng);
  }

  static Future<void> openDirections(BuildContext context,
      {required double endLat, required double endLng}) async {
    try {
      var (position, lat, lng) = await getCurrentLocation(context);

      const String googleMapsBaseUrl = 'https://www.google.com/maps/dir/?api=1';
      const String appleMapsBaseUrl = 'http://maps.apple.com/';

      final Uri googleMapsUrl = Uri.parse(
          '$googleMapsBaseUrl&origin=$lat,$lng&destination=$endLat,$endLng&travelmode=driving');

      final Uri appleMapsUrl =
          Uri.parse('$appleMapsBaseUrl?saddr=$lat,$lng&daddr=$endLat,$endLng');

      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(appleMapsUrl)) {
        await launchUrl(appleMapsUrl, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch map application.';
      }
    } catch (e) {
      print("Catch Error: $e");
    }
  }

  static showPermissionAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          /* shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius.all(
              SmoothRadius(
                cornerRadius: getSize(20),
                cornerSmoothing: 1,
              ),
            ),
          ), */
          title: BaseText(
            text: StringConstant.permissionDenied,
            fontWeight: FontWeight.w600,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                  text:
                      'Unable to get location. Go to Settings > Permissions, then allow following permissions and try again:'),
              SizedBox(
                height: getSize(20),
              ),
              Row(
                children: [
                  Icon(Icons.location_disabled),
                  SizedBox(
                    width: getSize(10),
                  ),
                  BaseText(
                    text: StringConstant.location,
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
                Geolocator.openLocationSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
