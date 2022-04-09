import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:per_note/models/image_model.dart';
import '../config/app_url_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class ImageRepository {
  Future uploadImagesToAlbum(albumId, List<File> images) async {
    var uri = Uri.parse(AppUrl.uploadImagesToAlbum);
    http.MultipartRequest request = http.MultipartRequest('POST', uri);
    request.fields['albumId'] = albumId;
    List<MultipartFile> newList = [];
    for (int i = 0; i < images.length; i++) {
      File imageFile = images[i];
      var stream = http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('image', stream, length,
          filename: basename(imageFile.path),
          contentType: MediaType('image', 'png'));

      newList.add(multipartFile);
    }
    request.files.addAll(newList);
    var response = await request.send();
    if (response.statusCode == 200) {
      debugPrint("Image Uploaded");
    } else {
      debugPrint("Upload Failed");
    }
  }

  Future<List<ImageModel>> getAllImagesByAlbumId(albumId) async {
    Response response = await get(
      Uri.parse(AppUrl.getAllImagesByAlbumId),
      headers: {
        'Content-Type': 'application/json',
        'albumid': albumId!,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['images'];
      return jsonResponse.map((image) => ImageModel.fromJson(image)).toList();
    } else {
      throw Exception('Failed to load task from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteImagesOfAlbum(String imageIds) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteImagesOfAlbum + imageIds),
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
