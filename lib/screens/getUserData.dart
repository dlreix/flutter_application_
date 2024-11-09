// ignore_for_file: file_names, prefer_const_constructors, avoid_print, library_private_types_in_public_api, unused_field

import 'package:flutter/material.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:flutter_application_arda/screens/showRoute.dart';
import 'package:flutter_application_arda/widgets/fetch_categories.dart';
import 'package:flutter_application_arda/widgets/multi_select_dropdown.dart';
import 'package:flutter_application_arda/widgets/custom_dropdown.dart';
import 'package:flutter_application_arda/widgets/send_cat_to_server.dart';

class GetUserData extends StatefulWidget {
  const GetUserData({Key? key}) : super(key: key);

  @override
  _GetUserDataState createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  DateTime dateTime = DateTime.now(); // Seçilen zamanı tutmak için
  String? _selectedTransport; // Vesait seçimi
  String? _selectedCategory; // Kategori seçimi
  String? _selectedLocation; // Lokasyon seçimi
  List<String> _categories = [];
  List<String> _selectedCategories = []; // Seçili kategorileri tutan liste
  bool _isLoading = true;

  final List<String> _transportOptions = ['Yaya', 'Araç'];
  final List<String> _locationOptions = ['Şehir İçi', 'Şehir Dışı'];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await CategoryService.fetchCategories();
    setState(() {
      _categories = categories;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rota Oluştur',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 49, 115),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 1. Seçim: Süre
                      Text(
                        'Süre',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Zaman Picker
                      TimePickerSpinner(
                        locale: const Locale('en', ''),
                        time: dateTime,
                        is24HourMode: true, // 24 saat formatı
                        isShowSeconds: false, // Saniye gösterilmez
                        itemHeight: 64,
                        normalTextStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                        ),
                        highlightedTextStyle: const TextStyle(
                          fontSize: 24,
                          color: Colors.blue,
                        ),
                        isForce2Digits: true,
                        onTimeChange: (time) {
                          setState(() {
                            dateTime = time; // Seçilen zamanı güncelle
                          });
                        },
                      ),

                      const SizedBox(height: 30),

                      // 2. Seçim: Vesait
                      buildDropdown(
                        hintText: 'Vesait Seçin',
                        value: _selectedTransport,
                        items: _transportOptions,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedTransport = newValue;
                          });
                        },
                      ),

                      // 3. Seçim: Kategori
                      MultiSelectDropdown(
                        items: _categories,
                        selectedItems: _selectedCategories,
                        onSelectionChanged: (selectedItems) {
                          setState(() {
                            _selectedCategories = selectedItems;
                          });
                        },
                      ),

                      // 4. Seçim: Lokasyon
                      buildDropdown(
                        hintText: 'Lokasyon Seçin',
                        value: _selectedLocation,
                        items: _locationOptions,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLocation = newValue;
                          });
                        },
                      ),

                      const SizedBox(height: 30),

                      // Rota Oluştur Butonu
                      ElevatedButton(
                        onPressed: () {
                          sendDataToServer(
                            selectedCategories: _selectedCategories,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowRoute(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.green, // Butonun yazı rengi
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ), // İç boşluklar
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                15), // Yuvarlatılmış kenarlar
                          ),
                        ),
                        child: const Text(
                          'Rota Oluştur',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
