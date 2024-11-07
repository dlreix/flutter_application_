// ignore_for_file: file_names, prefer_const_constructors, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:time_picker_spinner/time_picker_spinner.dart';
import 'package:flutter_application_arda/screens/showRoute.dart';

class GetUserData extends StatefulWidget {
  const GetUserData({super.key});

  @override
  _GetUserDataState createState() => _GetUserDataState();
}

class _GetUserDataState extends State<GetUserData> {
  DateTime dateTime = DateTime.now(); // Seçilen zamanı tutmak için

  String? _selectedTransport; // Vesait seçimi
  String? _selectedCategory; // Kategori seçimi
  String? _selectedLocation; // Lokasyon seçimi

  final List<String> _transportOptions = ['Yaya', 'Araç'];
  final List<String> _categoryOptions = [
    'Kategori 1',
    'Kategori 2',
    'Kategori 3',
    'Kategori 4',
    'Kategori 5',
    'Kategori 6',
    'Kategori 7',
  ];
  final List<String> _locationOptions = ['Şehir İçi', 'Şehir Dışı'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rota Oluştur',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400),
        ),
        backgroundColor: const Color.fromARGB(255, 11, 49, 115),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Seçim: Süre
              Text('Süre',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),

              // Zaman Picker
              TimePickerSpinner(
                locale: const Locale('en', ''),
                time: dateTime,
                is24HourMode: true, // 24 saat formatı
                isShowSeconds: false, // Saniye gösterilmez
                itemHeight: 60,
                normalTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.grey),
                highlightedTextStyle:
                    const TextStyle(fontSize: 24, color: Colors.blue),
                isForce2Digits: true,
                onTimeChange: (time) {
                  setState(() {
                    dateTime = time; // Seçilen zamanı güncelle
                  });
                },
              ),

              SizedBox(height: 20),

              // 2. Seçim: Vesait
              _buildDropdown(
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
              _buildDropdown(
                hintText: 'Kategori Seçin',
                value: _selectedCategory,
                items: _categoryOptions,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),

              // 4. Seçim: Lokasyon
              _buildDropdown(
                hintText: 'Lokasyon Seçin',
                value: _selectedLocation,
                items: _locationOptions,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLocation = newValue;
                  });
                },
              ),

              SizedBox(height: 20),

              // Rota Oluştur Butonu
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ShowRoute()));
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
                  'Rota Oluştur',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      width: 300, // Sabit genişlik ayarı
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(hintText),
          ),
          value: value,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: Colors.white, // Arka plan rengi
          style: TextStyle(
              color: Colors.black, fontSize: 16), // Metin rengi ve boyutu
          itemHeight: 50, // Her bir menü öğesinin yüksekliği
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
