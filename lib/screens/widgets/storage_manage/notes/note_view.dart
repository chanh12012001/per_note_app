import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/models/note_model.dart';
import 'package:per_note/providers/note_provider.dart';
import 'package:per_note/screens/widgets/storage_manage/notes/note_edit.dart';
import 'package:provider/provider.dart';

import '../../../../providers/loading_provider.dart';
import '../../../../services/toast_service.dart';
import '../../alert_dialog.dart';

class NoteView extends StatefulWidget {
  final Note note;
  const NoteView({
    Key? key,
    required this.note,
  }) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return MyAlertDialog(
                    title: 'Warning !!!',
                    subTitle: 'Bạn có chắc chắn muốn xoá ?',
                    action: () {
                      _deleteNote(widget.note);
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.note.title!,
                style: viewTitleStyle,
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                  ),
                ),
                Text(_getFormatedDate(widget.note.createdAt))
              ],
            ),
            if (widget.note.imageUrl != '')
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Image.network(widget.note.imageUrl!)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.note.content!,
                style: viewContentStyle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return NoteEdit(
                note: widget.note,
              );
            },
          ));
        },
        child: const Icon(Icons.edit),
      ),
    );
  }

  _getFormatedDate(date) {
    final format = DateFormat('yyyy-MM-ddTHH:mm:ssZ', 'en-US');
    var inputDate = format.parse(date);

    var outputFormat = DateFormat('MM/dd/yyyy hh:mm a');
    return outputFormat.format(inputDate);
  }

  _deleteNote(Note note) {
    LoadingProvider loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);
    NoteProvider noteProvider =
        Provider.of<NoteProvider>(context, listen: false);
    noteProvider.deleteNote(note).then(
      (response) {
        if (response['status']) {
          Navigator.pop(context);
          Navigator.pop(context);

          loadingProvider.setLoading(false);
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
  }
}
