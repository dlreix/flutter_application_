import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendDataToServer({
  required DateTime dateTime,
  required String? selectedTransport,
  required List<String> selectedCategories,
  required String? selectedLocation,
}) async {
  // Sunucuya gönderilecek URL
  final url = Uri.parse('http://routeplanner.ardayasar.com/api/generate_route');

  // Verilerinizi JSON formatında hazırlayın
  final Map<String, dynamic> data = {
    'time': dateTime.toIso8601String(), // Zamanı ISO formatında gönder
    'transport': selectedTransport,
    'categories': selectedCategories,
    'location': selectedLocation,
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
      print('Veriler başarıyla gönderildi');
    } else {
      // Hata durumu
      print('Hata oluştu: ${response.statusCode}');
    }
  } catch (e) {
    // Hata durumu (internet yok vs.)
    print('Bir hata oluştu: $e');
  }
}
