import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:per_note/models/note_model.dart';
import '../config/app_url_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../preferences/user_preference.dart';

class NoteRepository {
  // get userId
  String? userId;
  Future<String> getUserId() => UserPreferences().getUserId();

  Future<Note> createNewNote(
      String title, String content, File? imageFile) async {
    await getUserId().then((value) => userId = value);
    var stream =
        imageFile != null ? http.ByteStream(imageFile.openRead()) : null;
    if (imageFile != null) stream?.cast();
    var length = imageFile != null ? await imageFile.length() : 0;

    var uri = Uri.parse(AppUrl.createNewNote);

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = imageFile != null
        ? http.MultipartFile('image', stream!, length,
            filename: basename(imageFile.path),
            contentType: MediaType('image', 'png'))
        : null;

    request.fields["title"] = title;
    request.fields["content"] = content;
    request.fields["userId"] = userId!;
    if (imageFile != null) request.files.add(multipartFile!);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    final responseBody = json.decode(response.body);

    final Note topic = Note.fromJson(responseBody['note']);
    return topic;
  }

  Future<List<Note>> getNotesList() async {
    await getUserId().then((value) => userId = value);
    Response response = await get(
      Uri.parse(AppUrl.getAllNotes),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['notes'];
      return jsonResponse.map((note) => Note.fromJson(note)).toList();
    } else {
      throw Exception('Failed to load task from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteNote(Note note) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deteleNote + note.id!),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      result = {
        'status': true,
        'message': json.decode(response.body)['message'],
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['message'],
      };
    }

    return result;
  }

  Future<Map<String, dynamic>> updateNote(
      id, title, content, File? imageFile) async {
    Map<String, dynamic> result;
    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path),
          contentType: MediaType('image', 'png'));
      var uri = Uri.parse(AppUrl.updateNote + id);
      var request = http.MultipartRequest("PUT", uri);
      request.files.add(multipartFile);
      request.fields["title"] = title;
      request.fields["content"] = content;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        result = {
          'status': true,
          'message': json.decode(response.body)['message'],
        };
      } else {
        result = {
          'status': false,
          'message': json.decode(response.body)['message'],
        };
      }
      return result;
    } else {
      final Map<String, dynamic> noteData = {
        'title': title,
        'content': content
      };

      Response response = await put(
        Uri.parse(AppUrl.updateNote + id),
        body: json.encode(noteData),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        result = {
          'status': true,
          'message': json.decode(response.body)['message'],
        };
      } else {
        result = {'status': false, 'message': 'Lỗi Internet'};
      }
      return result;
    }
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = File(tempPath + (rng.nextInt(100)).toString() + '.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }
}
