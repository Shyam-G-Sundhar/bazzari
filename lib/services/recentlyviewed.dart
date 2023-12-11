import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class RecentlyViewedProducts {
  static const String _key = 'recently_viewed_products';
  static const String _apiBaseUrl = 'https://fakestoreapi.com';

  static Future<List<int>> getRecentlyViewedProductIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_key)?.map((id) => int.parse(id)) ?? [];
    return ids.toList();
  }

  static Future<void> addRecentlyViewedProductId(int productId) async {
    final prefs = await SharedPreferences.getInstance();
    List<int> ids = await getRecentlyViewedProductIds();

    ids.remove(productId);
    ids.insert(0, productId);

    await prefs.setStringList(_key, ids.map((id) => id.toString()).toList());
  }

  static Future<ProductDetails> fetchProductDetails(int productId) async {
    final response =
        await http.get(Uri.parse('$_apiBaseUrl/products/$productId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> productData = json.decode(response.body);

      return ProductDetails(
        title: productData['title'],
        price: productData['price'],
        description: productData['description'],
        image: productData['image'],
        ratings: productData['rating'],
      );
    } else {
      throw Exception('Failed to load product details');
    }
  }
}

class ProductDetails {
  final String title;
  final dynamic price;
  final String description;
  final String image;
  final dynamic ratings;

  ProductDetails({
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.ratings,
  });
}
