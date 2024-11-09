// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget buildDropdown({
  required String hintText,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
}) {
  return Container(
    width: 300, // Sabit genişlik ayarı
    margin: EdgeInsets.symmetric(vertical: 20),
    padding: EdgeInsets.symmetric(horizontal: 10),
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
        dropdownColor:
            const Color.fromARGB(255, 255, 255, 255), // Arka plan rengi
        elevation: 2, // Gölge seviyesi
        borderRadius: BorderRadius.circular(15), // Açılan menü köşe yuvarlama
        icon: Icon(Icons.arrow_drop_down, color: Colors.grey), // Ok simgesi
        hint: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            hintText,
            style: TextStyle(color: Colors.black),
          ),
        ),
        value: value,
        onChanged: onChanged,
        isExpanded: true,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                item,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}
