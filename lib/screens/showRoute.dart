// ignore_for_file: file_names, prefer_const_constructors, avoid_print, dead_code, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_application_arda/screens/map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class ShowRoute extends StatefulWidget {
  final List<String> selectedCategories;

  ShowRoute({required this.selectedCategories});

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
    if (widget.selectedCategories.isEmpty) {
      print('No categories selected');
      return;
    }

    // Select a random category
    final randomCategory = widget.selectedCategories[Random().nextInt(widget.selectedCategories.length)];

    final url = Uri.parse('http://213.238.180.86:1603/api/generate_route');
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode({"category": randomCategory}),
      );

      if (response.statusCode == 200) {
        setState(() {
          dataList = json.decode(response.body);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
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
                      final item = dataList[index];
                      return Card(
                        margin: EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                        child: ListTile(
                          title: Text(
                            item['placeName'] ?? 'Unknown Place',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Kategori: ${item['categorization'] ?? 'Unknown'}'),
                              Text('Ortalama Süre: ${item['waitingTime'] ?? 'N/A'} mins'),
                            ],
                          ),
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
