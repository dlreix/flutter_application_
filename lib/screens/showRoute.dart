// ignore_for_file: file_names, prefer_const_constructors, avoid_print, dead_code, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_arda/screens/map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowRoute extends StatefulWidget {
  @override
  _ShowRouteState createState() => _ShowRouteState();
}

class _ShowRouteState extends State<ShowRoute> {
  List<dynamic> dataList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'http://routeplanner.ardayasar.com/api/get_data'); // Örnek URL

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          dataList = json.decode(response.body);
        });
      } else {
        print('Hata: ${response.statusCode}');
      }
    } catch (e) {
      print('Bir hata oluştu: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rota Gösterimi'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Harita sayfasına yönlendirme
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // Butonun yazı rengi
                padding: EdgeInsets.symmetric(
                    horizontal: 100, vertical: 10), // İç boşluklar
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(15), // Yuvarlatılmış kenarlar
                ),
              ),
              child: Text(
                'Harita Sayfasına Git',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: dataList.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            dataList[index]['category'] ??
                                'Kategori Bilinmiyor',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              'Diğer bilgi: ${dataList[index]['details'] ?? 'Bilgi yok'}'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
