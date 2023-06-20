import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:per_note/models/category_model.dart';
import 'package:per_note/providers/category_provider.dart';
import 'package:provider/provider.dart';

class ChangeTaskDialog extends StatefulWidget {
  final String? oldColor;
  final String? oldIcon;
  final String? name;
  final Future<String> Function() reload;
  final Category? category;
  const ChangeTaskDialog(
      {Key? key,
      this.oldColor,
      this.oldIcon,
      this.name,
      required this.reload,
      this.category})
      : super(key: key);

  @override
  _ChangeTaskDialogState createState() => _ChangeTaskDialogState();
}

class _ChangeTaskDialogState extends State<ChangeTaskDialog> {
  final TextEditingController _textEditingController = TextEditingController();
  Color _selectedColor = Colors.blue;
  IconData _selectedIcon = Icons.check;
  int chooseColor = 0;
  int chooseIcon = 0;
  //chọn màu khi chỉnh sửa
  void _showColorPicker() {
    _selectedColor = Color(int.parse(widget.oldColor!, radix: 16));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn màu'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Color(int.parse(widget.oldColor!, radix: 16)),
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
                chooseColor++;
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
          ],
        );
      },
    );
  }
  //chọn icon khi chỉnh sửa
  void _showIconPicker() async {
    _selectedIcon =
        IconData(int.parse(widget.oldIcon!), fontFamily: 'MaterialIcons');
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
      _selectedIcon = icon;
      chooseIcon++;
      setState(() {});
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
            decoration: InputDecoration(
              hintText: '${widget.name}',
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
                    color: chooseColor != 0
                        ? _selectedColor
                        : Color(int.parse(widget.oldColor!, radix: 16)),
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
                  chooseIcon != 0
                      ? _selectedIcon
                      : IconData(int.parse(widget.oldIcon!),
                          fontFamily: 'MaterialIcons'),
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
            _textEditingController.text == ""
                ? _textEditingController.text = widget.name!
                : _textEditingController.text;
            String task = _textEditingController.text;
            // Xử lý logic thêm task tại đây
            // Sử dụng _selectedColor và _selectedIcon cho màu và biểu tượng
            categoryProvider.updateCategory(
                task,
                _selectedColor.value.toRadixString(16).toUpperCase(),
                _selectedIcon.codePoint.toString(),
                widget.category!);
            Navigator.of(context).pop();
            widget.reload();
          },
        ),
      ],
    );
  }
}
