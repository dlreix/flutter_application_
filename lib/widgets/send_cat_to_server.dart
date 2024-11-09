// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

Future<void> sendDataToServer({
  required List<String> selectedCategories,
}) async {
  // Sunucuya gönderilecek URL
  final url = Uri.parse('http://routeplanner.ardayasar.com/api/generate_route');

  if (selectedCategories.isEmpty) {
    print('Gönderilecek kategori bulunamadı');
    return;
  }

  // Rastgele bir kategori seçin
  final random = Random();
  final String randomCategory =
      selectedCategories[random.nextInt(selectedCategories.length)];

  // Veriyi istenen formatta hazırlayın
  final Map<String, String> data = {
    'category': randomCategory,
  };

  try {
    // HTTP POST isteğini gönderin
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      // Başarılı istek
      print('Veri başarıyla gönderildi');
    } else {
      // Hata durumu
      print('Hata oluştu: ${response.statusCode}');
    }
  } catch (e) {
    // Hata durumu (internet yok vs.)
    print('Bir hata oluştu: $e');
  }
}
