// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>>? onSelectionChanged;

  const MultiSelectDropdown({
    super.key,
    required this.items,
    required this.selectedItems,
    this.onSelectionChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> _tempSelectedItems;

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
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
      child: InkWell(
        onTap: () async {
          final List<String>? selected = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (context, setState) {
                  return AlertDialog(
                    alignment: AlignmentDirectional.center,
                    title: const Text(
                      'Kategorileri Seçin',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: widget.items.map((item) {
                          return CheckboxListTile(
                            value: _tempSelectedItems.contains(item),
                            title: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.black),
                            ),
                            onChanged: (bool? isChecked) {
                              setState(() {
                                if (isChecked == true) {
                                  _tempSelectedItems.add(item);
                                } else {
                                  _tempSelectedItems.remove(item);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child:
                            const Text('İptal', style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child:
                            const Text('Tamam', style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          Navigator.of(context).pop(_tempSelectedItems);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
          if (selected != null) {
            setState(() {
              _tempSelectedItems = selected;
              widget.onSelectionChanged?.call(_tempSelectedItems);
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kategori Seçin (${_tempSelectedItems.length})',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
