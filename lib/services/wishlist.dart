import 'package:http/http.dart' as http;
import 'dart:convert';

class WishlistService {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<Map<String, dynamic>> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product details');
    }
  }
}
