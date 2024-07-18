import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;
import 'package:shift/domain/core/math_utils.dart';
import 'package:shift/domain/core/string_constant.dart';
import 'package:shift/domain/core/svg_image_constants.dart';
import 'package:shift/presentation/common/widgets/base_text.dart';
import 'package:shift/presentation/core/style/app_colors.dart';
import 'package:shift/presentation/core/widgets/inputs/custom_text_field.dart';

@RoutePage(name: 'locationExample')

// class LocationExample extends StatefulWidget {
//   @override
//   _LocationExampleState createState() => _LocationExampleState();
// }

// class _LocationExampleState extends State<LocationExample> {
//   final homeScaffoldKey = GlobalKey<ScaffoldState>();
//   final searchScaffoldKey = GlobalKey<ScaffoldState>();

//   Mode _mode = Mode.overlay;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: homeScaffoldKey,
//       appBar: AppBar(
//         title: Text('Places Autocomplete Demo'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _handlePressButton,
//           child: Text('Search places'),
//         ),
//       ),
//     );
//   }

//   Future<void> _handlePressButton() async {
//     Prediction? p = await PlacesAutocomplete.show(
//         context: context,
//         apiKey: "YOUR_API_KEY",
//         onError: onError,
//         mode: _mode,
//         language: "en",
//         components: [Component(Component.country, "us")]);

//     displayPrediction(p!, homeScaffoldKey.currentState);
//   }

//   void onError(PlacesAutocompleteResponse response) {
//     // homeScaffoldKey.currentState!.showSnackBar(
//     //   SnackBar(content: Text(response.errorMessage!)),
//     // );
//   }

//   Future<Null> displayPrediction(Prediction p, ScaffoldState? scaffold) async {
//     if (p != null) {
//       GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: "YOUR_API_KEY");
//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId!);
//       final lat = detail.result.geometry!.location.lat;
//       final lng = detail.result.geometry!.location.lng;

//       // scaffold!.showSnackBar(
//       //   SnackBar(content: Text("${p.description} - $lat/$lng")),
//       // );
//     }
//   }
// }

class LocationExample extends StatefulWidget {
  @override
  _LocationExampleState createState() => _LocationExampleState();
}

class _LocationExampleState extends State<LocationExample> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  late GoogleMapsPlaces _places;

  @override
  void initState() {
    super.initState();
    _places =
        GoogleMapsPlaces(apiKey: "YOUR_API_KEY"); // Replace with your API key
  }

  Future<void> _handlePressButton() async {
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: "YOUR_API_KEY",
      onError: onError,
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "us")],
    );

    if (p != null) {
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId!);
      final place = detail.result.formattedAddress;
      _controller.text = place!;
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    // homeScaffoldKey.currentState?.showSnackBar(
    //   SnackBar(content: Text(response.errorMessage!)),
    // );
  }

  Future<void> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": "AIzaSyCiVTuKvc7IrDDG_onVY-CdAlKz_Mo_XoE",
      },
    );

    String? response = await fetchUrl(uri);
    if (response != null) {
      print("API RESPONSE----> ${response}");
      setState(() {
        _placeList = json.decode(response)['predictions'];
      });
    }
  }

  List<dynamic> _placeList = [];

  Future<String?> fetchUrl(Uri uri, {Map<String, String>? headers}) async {
    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        return response.body;
      }
    } catch (e) {
      print("LOCATION CATCH ERROR: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text('Google Places Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CustomTextField(
              labelText: StringConstant.locationAddress,
              isLabelPadding: true,
              hintText: StringConstant.locationAddress,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(14),
                  vertical: getSize(14),
                ),
                child: SvgPicture.asset(
                  SvgImageConstant.locationIcon,
                  height: getSize(24),
                  width: getSize(24),
                  color: AppColors.primaryColor,
                ),
              ),
              onChanged: (value) {
                placeAutoComplete(value);
              },
            ),
            Container(
              color: AppColors.white,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _placeList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BaseText(text: _placeList[index]["description"]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
