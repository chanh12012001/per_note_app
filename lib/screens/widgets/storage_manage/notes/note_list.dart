import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:per_note/providers/note_provider.dart';
import 'package:per_note/screens/widgets/storage_manage/notes/note_view.dart';
import 'package:provider/provider.dart';

import '../../../../models/note_model.dart';
import 'note_card.dart';

class NoteList extends StatefulWidget {
  final List<Note> notes;

  const NoteList({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(builder: ((context, noteProvider, child) {
      return Padding(
        padding: const EdgeInsets.only(top: 25),
        child: ListView.builder(
          itemCount: widget.notes.length,
          itemBuilder: (context, index) {
            Note note = widget.notes[index];
            return AnimationConfiguration.staggeredList(
              position: index,
              child: SlideAnimation(
                child: FadeInAnimation(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              NoteView(note: note),
                        ),
                      );
                    },
                    child: NoteCard(note: note),
                  ),
                ),
              ),
            );
          },
        ),
      );
    }));
  }
}
