import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryService {
  static Future<List<String>> fetchCategories() async {
    try {
      final response = await http
          .get(Uri.parse('https://routeplanner.ardayasar.com/api/categories'));
      if (response.statusCode == 200) {
        return List<String>.from(json.decode(response.body));
      } else {
        throw Exception('Veri çekme hatası: ${response.statusCode}');
      }
    } catch (e) {
      print('Hata: $e');
      return [];
    }
  }
}
