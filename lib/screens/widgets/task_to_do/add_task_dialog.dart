import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:provider/provider.dart';

class AddTaskDialog extends StatefulWidget {
  final Future<String> Function() reload;
  const AddTaskDialog({Key? key, required this.reload}) : super(key: key);

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  Color _selectedColor = Colors.blue;
  IconData _selectedIcon = Icons.check;
  //chọn màu cho loại công việc
  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn màu'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (Color color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Chọn'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  //chọn icon cho loại công việc
  void _showIconPicker() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(
      context,
      iconSize: 40,
      iconPickerShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      closeChild: const Icon(Icons.close),
      searchHintText: 'Tìm kiếm...',
      noResultsText: 'Không tìm thấy kết quả',
      iconColor: Colors.blue,
      showTooltips: true,
    );

    if (icon != null) {
      setState(() {
        _selectedIcon = icon;
      });
    }
  }

  // ...

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    return AlertDialog(
      title: const Text('Thao tác với loại việc'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _textEditingController,
            decoration: const InputDecoration(
              hintText: 'Nhập tên',
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              const Text('Màu:'),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _showColorPicker,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _selectedColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              const Text('Biểu tượng:'),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _showIconPicker,
                child: Icon(
                  _selectedIcon,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Lưu'),
          onPressed: () {
            String task = _textEditingController.text;
            // Xử lý logic thêm task tại đây
            // Sử dụng _selectedColor và _selectedIcon cho màu và biểu tượng
            categoryProvider.createNewCategory(
                task,
                _selectedColor.value.toRadixString(16).toUpperCase(),
                _selectedIcon.codePoint.toString());
            Navigator.of(context).pop();
            widget.reload();
          },
        ),
      ],
    );
  }
}
