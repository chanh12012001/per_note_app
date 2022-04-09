import 'dart:convert';
import 'package:http/http.dart';
import 'package:per_note/models/album_model.dart';
import '../config/app_url_config.dart';
import '../preferences/user_preference.dart';

class AlbumRepository {
  // get userId
  String? userId;
  Future<String> getUserId() => UserPreferences().getUserId();

  Future<Album> createNewAlbum(String nameAlbum) async {
    await getUserId().then((value) => userId = value);

    final Map<String, dynamic> albumData = {
      'name': nameAlbum,
      'userId': userId,
    };

    Response response = await post(
      Uri.parse(AppUrl.createNewAlbum),
      body: json.encode(albumData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody = await json.decode(response.body)['album'];
      return Album.fromJson(responseBody);
    } else {
      throw Exception('Failed to add album');
    }
  }

  Future<List<Album>> getAlbumsList() async {
    await getUserId().then((value) => userId = value);

    Response response = await get(
      Uri.parse(AppUrl.getAllAlbums),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['albums'];
      return jsonResponse.map((album) => Album.fromJson(album)).toList();
    } else {
      throw Exception('Failed to load task from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteAlbum(Album album) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteAlbum + album.id!),
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

  Future<Map<String, dynamic>> updateAlbum(Map<String, dynamic> params) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> albumData = {
      'name': params['name'],
    };
    Response response = await put(
      Uri.parse(AppUrl.updateAlbum + params['id']),
      body: json.encode(albumData),
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
}
