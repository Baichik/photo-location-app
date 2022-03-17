import 'dart:convert';

import 'package:http/http.dart' as http;

const APIKey = 'AIzaSyAZl3Lp-CQLkK9Kx3kvhJoXr264bju3ZJ4';

class NetworkHelper {
  static String generateLocationPreviewImage(
      double? latitude, double? longitude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude, $longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7C$latitude,$longitude&key=$APIKey';
  }

  static Future<String> getPlaceAdress(double lat, double lon) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$APIKey';
    final response = await http.get(Uri.parse(url));

    return json.decode(response.body)['results'][0]['formatted_address'];
  }
}
