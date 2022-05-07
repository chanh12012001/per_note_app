import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:per_note/models/healthy_index_model.dart';
import 'package:per_note/providers/healthy_index_provider.dart';
import 'package:provider/provider.dart';
import '../../../../services/toast_service.dart';
import '../widgets.dart';

class AddAndEditHealthyIndexDialog extends StatefulWidget {
  final HealthyIndex? healthyIndex;
  const AddAndEditHealthyIndexDialog({
    Key? key,
    this.healthyIndex,
  }) : super(key: key);

  @override
  State<AddAndEditHealthyIndexDialog> createState() =>
      _DetailAddAndEditHealthyIndexDialoggState();
}

class _DetailAddAndEditHealthyIndexDialoggState
    extends State<AddAndEditHealthyIndexDialog> {
  ToastService toast = ToastService();
  bool _loading = false;
  File? file;

  final TextEditingController _topicNameController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HealthyIndexProvider healthyIndexProvider =
        Provider.of<HealthyIndexProvider>(context);
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height / 1.5,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.healthyIndex != null
                    ? 'Cập nhật chỉ số'
                    : "Thêm chỉ số mới",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.asset(
                'assets/images/pattern.png',
                height: 20,
                width: 200,
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedInputField(
                icon: Icons.photo_album,
                hintText: 'Tên chỉ số',
                onChanged: (value) {
                  if (widget.healthyIndex != null) {
                    widget.healthyIndex!.name = value;
                  }
                },
                controller: widget.healthyIndex != null
                    ? TextEditingController(text: widget.healthyIndex!.name)
                    : _topicNameController,
              ),
              RoundedInputField(
                icon: Icons.ac_unit,
                hintText: 'Đơn vị tính',
                onChanged: (value) {
                  if (widget.healthyIndex != null) {
                    widget.healthyIndex!.unit = value;
                  }
                },
                controller: widget.healthyIndex != null
                    ? TextEditingController(text: widget.healthyIndex!.unit)
                    : _unitController,
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  imagePicker();
                },
                child: Container(
                  color: Colors.grey[100],
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: widget.healthyIndex == null
                        ? file != null
                            ? Image.file(
                                file!,
                                height: 300,
                                fit: BoxFit.fill,
                              )
                            : const Center(
                                child: Text('chọn ảnh'),
                              )
                        : file != null
                            ? Image.file(
                                file!,
                                height: 300,
                                fit: BoxFit.fill,
                              )
                            : FutureBuilder<File>(
                                future:
                                    healthyIndexProvider.convertUrlImageToFile(
                                        widget.healthyIndex!.iconUrl!),
                                builder: (context, snapshot) {
                                  file = snapshot.data;
                                  if (snapshot.hasError) {
                                    return Text("${snapshot.error}");
                                  }
                                  return snapshot.data != null
                                      ? Image.file(
                                          snapshot.data!,
                                          height: 300,
                                          fit: BoxFit.fill,
                                        )
                                      : Container();
                                },
                              ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _loading == true
                  ? const ColorLoader()
                  : Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildButton(
                            text: 'Huỷ bỏ',
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: Colors.grey,
                          ),
                          _buildButton(
                            text: 'OK',
                            onPressed: () {
                              widget.healthyIndex != null
                                  ? Container()
                                  : _addHealthyIndex(_topicNameController.text,
                                      _unitController.text, file);
                              setState(() {
                                _loading = true;
                              });
                            },
                            backgroundColor: Colors.teal[300]!,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }

  _buildButton(
      {required String text,
      required Function onPressed,
      required Color backgroundColor}) {
    return ConstrainedBox(
      constraints: const BoxConstraints.tightFor(width: 100, height: 40),
      child: ElevatedButton(
        child: Text(
          text,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.fromLTRB(20, 3, 20, 3)),
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  void imagePicker() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        file = File(image.path);
      });
    }
  }

  _addHealthyIndex(String name, String unit, File? file) async {
    HealthyIndexProvider healthyIndexProvider =
        Provider.of<HealthyIndexProvider>(context, listen: false);

    if (name == '' || unit == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập đầy đủ thông tin',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
      setState(() {
        _loading = false;
      });
    } else {
      healthyIndexProvider
          .createNewHealthyIndex(name, unit, file)
          .then((value) {
        Navigator.pop(context);
        toast.showToast(
          context: context,
          message: 'Thêm thành công',
          icon: Icons.error,
          backgroundColor: Colors.green,
        );
      });
      setState(() {
        _loading = false;
      });
    }
  }

  // _updateTopic(id, name, File? file1) {
  //   TopicProvider topicProvider =
  //       Provider.of<TopicProvider>(context, listen: false);

  //   topicProvider.updateTopic(id, name, file1!).then(
  //     (response) {
  //       if (response['status']) {
  //         Navigator.pop(context);
  //         toast.showToast(
  //           context: context,
  //           message: response['message'],
  //           icon: Icons.error,
  //           backgroundColor: Colors.green,
  //         );
  //       } else {
  //         toast.showToast(
  //           context: context,
  //           message: response['message'],
  //           icon: Icons.error,
  //           backgroundColor: Colors.redAccent,
  //         );
  //       }
  //     },
  //   );

  //   setState(() {
  //     _loading = false;
  //   });
  // }
}
