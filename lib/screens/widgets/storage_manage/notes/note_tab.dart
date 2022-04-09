import 'package:flutter/material.dart';
import 'package:per_note/models/note_model.dart';
import 'package:per_note/providers/note_provider.dart';
import 'package:per_note/screens/widgets/storage_manage/notes/note_edit.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import '../../../../config/theme.dart';
import 'package:per_note/services/toast_service.dart';

import 'note_list.dart';

class NoteTab extends StatefulWidget {
  const NoteTab({Key? key}) : super(key: key);

  @override
  State<NoteTab> createState() => _NoteTabState();
}

class _NoteTabState extends State<NoteTab> {
  ToastService toast = ToastService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return const NoteEdit();
            },
          ));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add_box),
      ),
      body: _showNotes(),
    );
  }

  _showNotes() {
    NoteProvider noteProvider =
        Provider.of<NoteProvider>(context, listen: false);

    return FutureBuilder<List<Note>>(
      future: noteProvider.getNotesList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return snapshot.hasData
            ? NoteList(notes: snapshot.data!)
            : const Center(
                child: ColorLoader(),
              );
      },
    );
  }
}
