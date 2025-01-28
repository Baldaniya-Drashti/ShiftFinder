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

  static Future<Location?> getLocationDetailsFromLatLng(
      double? lat, double? lng) async {
    final apiKey = dotenv.env['GOOGLE_PLACE_API_KEY'];
    // Example API endpoint or geocoding service
    // final response = await http.get(Uri.parse('https://geocoding.api.com?lat=$lat&lng=$lng'));
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey'));

    print(
        "Selected Location full details---> ${jsonEncode(json.decode(response.body))}");

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
}
