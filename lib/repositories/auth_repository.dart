import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../config/app_url_config.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

import '../models/user_model.dart';

class AuthRepository {
  Future<User> updateAvatar(userId, File? imageFile) async {
    if (imageFile != null) {
      var stream = http.ByteStream(imageFile.openRead());
      stream.cast();
      var length = await imageFile.length();
      var multipartFile = http.MultipartFile('avatar', stream, length,
          filename: basename(imageFile.path),
          contentType: MediaType('avatar', 'png'));
      var uri = Uri.parse(AppUrl.updateAvatar);
      var request = http.MultipartRequest("PUT", uri);
      request.files.add(multipartFile);
      request.fields["userId"] = userId;
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        return User.fromJson(responseBody['user']);
      } else {
        throw Exception('Failed to load blog from the Internet');
      }
    } else {
      throw Exception('Chưa chọn ảnh');
    }
  }

  Future<User> updateUserInfo(userId, name, sex, email) async {
    final Map<String, dynamic> userData = {
      'userId': userId,
      'name': name,
      'sex': sex,
      'email': email,
    };
    Response response = await put(
      Uri.parse(AppUrl.updateUserInfo),
      body: json.encode(userData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      return User.fromJson(responseBody['user']);
    } else {
      throw Exception('Failed to load blog from the Internet');
    }
  }
}
