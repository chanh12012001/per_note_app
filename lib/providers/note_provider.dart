import 'dart:io';

import 'package:flutter/material.dart';
import 'package:per_note/models/note_model.dart';
import 'package:per_note/repositories/note_repository.dart';

class NoteProvider extends ChangeNotifier {
  NoteRepository noteRepository = NoteRepository();
  static List<Note> notes = [];

  // get all album
  Future<List<Note>> getNotesList() async {
    notes = await noteRepository.getNotesList();
    return notes;
  }

  Future<Note> createNewAlbum(
      String title, String content, File? imageFile) async {
    Note newNote =
        await noteRepository.createNewNote(title, content, imageFile);
    notes.add(newNote);
    notifyListeners();
    return newNote;
  }

  Future<Map<String, dynamic>> deleteNote(Note note) async {
    Map<String, dynamic> result;
    result = await noteRepository.deleteNote(note);
    notes.remove(note);
    notifyListeners();
    return result;
  }

  Future<Map<String, dynamic>> updateNote(
      id, title, content, File? file) async {
    Map<String, dynamic> result;
    result = await noteRepository.updateNote(id, title, content, file);
    notifyListeners();
    return result;
  }

  Future<File> convertUrlImageToFile(String imageUrl) async {
    File file = await noteRepository.urlToFile(imageUrl);
    notifyListeners();
    return file;
  }
}
