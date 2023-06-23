import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/providers/note_provider.dart';
import 'package:provider/provider.dart';
import '../../../../models/note_model.dart';
import '../../../../services/toast_service.dart';

class NoteEdit extends StatefulWidget {
  final Note? note;

  const NoteEdit({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<NoteEdit> createState() => _NoteEditState();
}

class _NoteEditState extends State<NoteEdit> {
  bool loading = false;
  ToastService toast = ToastService();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  File? _image;
  final picker = ImagePicker();
  Color _selectedColor = Colors.blue;
  int chooseColor = 0;

  //chọn màu khi chỉnh sửa
  void _showColorPicker() {
    _selectedColor = Color(int.parse(
        widget.note != null ? widget.note!.color! : "FF2196F3",
        radix: 16));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chọn màu'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: Color(int.parse(
                  widget.note != null ? widget.note!.color! : "FF2196F3",
                  radix: 16)),
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

  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          GestureDetector(
            onTap: () => imagePicker(ImageSource.camera),
            child: Image.asset(
              "assets/icons/ic_camera.png",
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(width: 13),
          GestureDetector(
            onTap: () => imagePicker(ImageSource.gallery),
            child: Image.asset(
              "assets/icons/ic_add_photo.png",
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(width: 13),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              "assets/icons/ic_delete.png",
              width: 25,
              height: 25,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: widget.note != null
                    ? TextEditingController(text: widget.note!.title)
                    : titleController,
                onChanged: (value) {
                  if (widget.note != null) {
                    widget.note!.title = value;
                  }
                },
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                )),
                decoration: InputDecoration(
                  hintText: 'Nhập tiêu đề cho ghi chú',
                  hintStyle: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  )),
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              // height: 300.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: widget.note == null
                    ? _image != null
                        ? Image.file(
                            _image!,
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : Container()
                    : _image != null
                        ? Image.file(
                            _image!,
                            height: 300,
                            fit: BoxFit.cover,
                          )
                        : FutureBuilder<File>(
                            future: noteProvider
                                .convertUrlImageToFile(widget.note!.imageUrl!),
                            builder: (context, snapshot) {
                              _image = snapshot.data;
                              if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return snapshot.hasData
                                  ? snapshot.data != null
                                      ? Image.file(
                                          snapshot.data!,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        )
                                      : Container()
                                  : Container();
                            },
                          ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: widget.note != null
                    ? TextEditingController(text: widget.note!.content)
                    : contentController,
                onChanged: (value) {
                  if (widget.note != null) {
                    widget.note!.content = value;
                  }
                },
                maxLines: null,
                // style: createContent,
                decoration: InputDecoration(
                  hintText: 'Viết nội dung...',
                  // hintStyle: createContent,
                  border: InputBorder.none,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Row(
                children: <Widget>[
                  const Text('Chọn màu:'),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _showColorPicker,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: chooseColor != 0
                            ? _selectedColor
                            : Color(int.parse(
                                widget.note != null
                                    ? widget.note!.color!
                                    : "FF2196F3",
                                radix: 16)),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.note != null
              ? _updateNote(widget.note!.id, widget.note!.title,
                  widget.note!.content, _image)
              : _addNote(titleController.text, contentController.text, _image);
          setState(() {
            loading = true;
          });
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void imagePicker(ImageSource imageSource) async {
    XFile? image = await ImagePicker().pickImage(source: imageSource);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _addNote(title, content, File? imageFile) async {
    NoteProvider noteProvider =
        Provider.of<NoteProvider>(context, listen: false);

    if (title == '' || content == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập đầy đủ tiêu đề và nội dung',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      await noteProvider.createNewNote(
          title,
          _selectedColor.value.toRadixString(16).toUpperCase(),
          content,
          imageFile);
      Navigator.pop(context);
      toast.showToast(
        context: context,
        message: 'Thêm thành công',
        icon: Icons.error,
        backgroundColor: Colors.green,
      );
    }
    setState(() {
      loading = false;
    });
  }

  _updateNote(id, title, content, File? file) {
    NoteProvider noteProvider =
        Provider.of<NoteProvider>(context, listen: false);

    noteProvider
        .updateNote(id, title,
            _selectedColor.value.toRadixString(16).toUpperCase(), content, file)
        .then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          Navigator.pop(context);
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.green,
          );
        } else {
          toast.showToast(
            context: context,
            message: response['message'],
            icon: Icons.error,
            backgroundColor: Colors.redAccent,
          );
        }
      },
    );

    setState(() {
      loading = false;
    });
  }
}
