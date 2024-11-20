import 'dart:convert';
import 'package:http/http.dart' as http;

class API {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev/list';

  static Future<Map<String, dynamic>> getRestaurant(
      {int limit = 10, int offset = 0}) async {
    final response =
        await http.get(Uri.parse('$_baseUrl?limit=$limit&offset=$offset'));
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch articles');
    }
  }

  static Future<Map<String, dynamic>> getRestaurantDetails(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl$id/'));
    if (response.body.isNotEmpty) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to fetch article details');
    }
  }
}
