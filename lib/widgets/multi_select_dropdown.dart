import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> items;
  final List<String> selectedItems;
  final ValueChanged<List<String>>? onSelectionChanged; // Callback fonksiyonu

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
  List<String> _tempSelectedItems = [];

  @override
  void initState() {
    super.initState();
    _tempSelectedItems = List.from(widget.selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final List<String>? selected = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Kategorileri Seçin'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: widget.items.map((item) {
                    return CheckboxListTile(
                      value: _tempSelectedItems.contains(item),
                      title: Text(item),
                      onChanged: (bool? isChecked) {
                        setState(() {
                          if (isChecked != null && isChecked) {
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
                  child: const Text('İptal'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop(_tempSelectedItems);
                  },
                ),
              ],
            );
          },
        );
        if (selected != null) {
          setState(() {
            _tempSelectedItems = selected;
            if (widget.onSelectionChanged != null) {
              widget.onSelectionChanged!(_tempSelectedItems); // Seçimleri bildir
            }
          });
        }
      },
      child: Text('Kategori Seçin (${_tempSelectedItems.length})'),
    );
  }
}
