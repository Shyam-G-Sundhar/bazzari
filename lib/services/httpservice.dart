import 'dart:convert';
import 'package:bazzari/screens/productscreen/product.dart';
import 'package:bazzari/services/product.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static const String baseUrl = 'https://fakestoreapi.com';

  static Future<List<Map<String, dynamic>>> fetchCategoriesWithImages() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));

    if (response.statusCode == 200) {
      List<String> categories = List<String>.from(json.decode(response.body));
      List<Map<String, dynamic>> categoryList = [];

      for (String category in categories) {
        final categoryResponse =
            await http.get(Uri.parse('$baseUrl/products/category/$category'));

        if (categoryResponse.statusCode == 200) {
          List<Map<String, dynamic>> productsList =
              List<Map<String, dynamic>>.from(
                  json.decode(categoryResponse.body));
          Map<String, dynamic> categoryData = {
            'category': category,
            'image': productsList.isNotEmpty ? productsList[0]['image'] : '',
          };
          categoryList.add(categoryData);
        } else {
          throw Exception('Failed to load category data for $category');
        }
      }

      return categoryList;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchRandomProducts() async {
    try {
      final trendingProducts = await fetchTrendingProducts();

      trendingProducts.shuffle();

      return trendingProducts.take(6).toList();
    } catch (e) {
      throw Exception('Failed to fetch random products: $e');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchTrendingProducts() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> productsList =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        productsList.sort((a, b) {
          DateTime? dateA =
              a['date'] != null ? DateTime.tryParse(a['date']) : null;
          DateTime? dateB =
              b['date'] != null ? DateTime.tryParse(b['date']) : null;

          if (dateA != null && dateB != null) {
            return dateB.compareTo(dateA);
          } else if (dateA != null) {
            return -1;
          } else if (dateB != null) {
            return 1;
          } else {
            return 0;
          }
        });

        return productsList;
      } else {
        throw Exception('Failed to load trending products');
      }
    } catch (e) {
      throw Exception('Failed to fetch trending products: $e');
    }
  }

  static Future<ProductList> fetchProductDetails(int productId) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$productId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> productData = json.decode(response.body);

      return ProductList.fromJson(productData);
    } else {
      throw Exception('Failed to load product details');
    }
  }

  static Future<List<Map<String, dynamic>>> searchProducts(String query) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/products'));

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> allProducts =
            List<Map<String, dynamic>>.from(json.decode(response.body));

        List<Map<String, dynamic>> searchResults = allProducts
            .where((product) =>
                product['title']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                product['description']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                product['image']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                product['id']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()) ||
                product['rating']
                    .toString()
                    .toLowerCase()
                    .contains(query.toLowerCase()))
            .toList();

        return searchResults;
      } else {
        throw Exception('Failed to search products');
      }
    } catch (e) {
      throw Exception('Error searching products: $e');
    }
  }
}
