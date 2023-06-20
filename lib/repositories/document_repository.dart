import 'dart:convert';
import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:per_note/config/app_url_config.dart';
import 'package:per_note/models/document_model.dart';
import 'package:path/path.dart';

class DocumentRepository {
  Future uploadDocument(List<File> documents) async {
    var uri = Uri.parse(AppUrl.uploadImagesToAlbum);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    List<MultipartFile> newList = [];
    for (int i = 0; i < documents.length; i++) {
      File documentFile = documents[i];
      var stream = http.ByteStream(documentFile.openRead());
      stream.cast();
      var length = await documentFile.length();
      var multipartFile = http.MultipartFile('document', stream, length,
          filename: basename(documentFile.path),);

      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var response = await request.send();
    if (response.statusCode == 200) {
      debugPrint("Document Uploaded");
    } else {
      debugPrint("Upload Failed");
    }
  }

  Future<List<DocumentModel>> getAllDocument() async {
    Response response = await get(
      Uri.parse(AppUrl.getAllImagesByAlbumId),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['documents'];
      return jsonResponse.map((document) => DocumentModel.fromJson(document)).toList();
    } else {
      throw Exception('Failed to load task from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteDocument(String documentIds) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteImagesOfAlbum + documentIds),
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
        'message': 'Xoá thất bại',
      };
    }

    return result;
  }
}
