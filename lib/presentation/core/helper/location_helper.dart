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
