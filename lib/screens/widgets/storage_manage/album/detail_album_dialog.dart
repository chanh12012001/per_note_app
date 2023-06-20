import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:per_note/models/album_model.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../providers/album_provider.dart';
import '../../../../services/toast_service.dart';

class DetailAlbumDialog extends StatefulWidget {
  final Album? album;
  const DetailAlbumDialog({
    Key? key,
    this.album,
  }) : super(key: key);

  @override
  State<DetailAlbumDialog> createState() => _DetailAlbumDialogState();
}

class _DetailAlbumDialogState extends State<DetailAlbumDialog> {
  ToastService toast = ToastService();
  bool _loading = false;
  final TextEditingController _albumNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 260,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.album != null ? 'Cập nhật Album' : "Thêm Album mới",
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
                hintText: 'Tên album',
                onChanged: (value) {
                  if (widget.album != null) {
                    widget.album!.name = value;
                  }
                },
                controller: widget.album != null
                    ? TextEditingController(text: widget.album!.name)
                    : _albumNameController,
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
                              widget.album != null
                                  ? _updateAlbum(widget.album!)
                                  : _addAlbum(_albumNameController.text);
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
        child: Text(
          text,
          style: GoogleFonts.lato(
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  _addAlbum(nameAlbum) async {
    AlbumProvider albumProvider =
        Provider.of<AlbumProvider>(context, listen: false);

    if (nameAlbum == '') {
      toast.showToast(
        context: context,
        message: 'Vui lòng nhập tên Album',
        icon: Icons.error,
        backgroundColor: Colors.redAccent,
      );
    } else {
      await albumProvider.createNewAlbum(nameAlbum);
      Navigator.pop(context);
      toast.showToast(
        context: context,
        message: 'Thêm thành công',
        icon: Icons.error,
        backgroundColor: Colors.green,
      );
    }
    setState(() {
      _loading = false;
    });
  }

  _updateAlbum(Album album) {
    AlbumProvider albumProvider =
        Provider.of<AlbumProvider>(context, listen: false);
    Map<String, dynamic> params = <String, dynamic>{};
    params['id'] = album.id;
    params['name'] = album.name;
    albumProvider.updateAlbum(params).then(
      (response) {
        if (response['status']) {
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
      _loading = false;
    });
  }
}
