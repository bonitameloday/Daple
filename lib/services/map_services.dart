import 'package:google_map/models/auto_complete_result.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MapServices {
  final String key = 'AIzaSyDnxE7b3k0znhs5k6Y-lOz8-hZKvTUEGr0';
  final String types = 'geocode';

  Future<List<AutoCompleteResult>> searchPlaces(String searchInput) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchInput&types=$types&key=%key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['predicts'] as List;

    return results.map((e) => AutoCompleteResult.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getPlace(String? input) async {
    final String url =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$input&key=$key';

    var response = await http.get(Uri.parse(url));

    var json = convert.jsonDecode(response.body);

    var results = json['result'] as Map<String, dynamic>;

    return results;
  }
}