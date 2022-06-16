import 'dart:convert';
import 'package:http/http.dart';
import 'package:per_note/models/detail_healthy_index_model.dart';
import '../config/app_url_config.dart';
import '../preferences/user_preference.dart';

class DetailHealthyIndexRepository {
  // get userId
  String? userId;
  Future<String> getUserId() => UserPreferences().getUserId();

  Future<DetailHealthyIndex> createNewDetailHealthyIndex(
      date, time, value, healthyIndexId) async {
    await getUserId().then((value) => userId = value);

    final Map<String, dynamic> detailHealthyData = {
      'createAtDate': date,
      'createAtTime': time,
      'indexValue': value,
      'healthyIndexId': healthyIndexId,
      "userId": userId
    };

    Response response = await post(
      Uri.parse(AppUrl.createNewDetailHealthyIndex),
      body: json.encode(detailHealthyData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final responseBody =
          await json.decode(response.body)['detailHealthyIndex'];
      return DetailHealthyIndex.fromJson(responseBody);
    } else {
      throw Exception('Failed to create');
    }
  }

  Future<List<DetailHealthyIndex>> getAllDetailHealthyIndexByUserId(
      healthyIndexId) async {
    await getUserId().then((value) => userId = value);

    Response response = await get(
      Uri.parse(AppUrl.getAllDetailHealthyIndexByUserId + healthyIndexId),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['detailHealthyIndexs'];
      return jsonResponse
          .map((detailHealthyIndex) =>
              DetailHealthyIndex.fromJson(detailHealthyIndex))
          .toList();
    } else {
      throw Exception('Failed to load detail healthy index from the Internet');
    }
  }

  Future<DetailHealthyIndex> getDetailHealthyIndexLastest(
      healthyIndexId) async {
    await getUserId().then((value) => userId = value);

    Response response = await get(
      Uri.parse(AppUrl.getDetailHealthyIndexLastest + healthyIndexId),
      headers: {
        'Content-Type': 'application/json',
        'userid': userId!,
      },
    );

    if (response.statusCode == 200) {
      final responseBody =
          await json.decode(response.body)['detailHealthyIndex'];

      return DetailHealthyIndex.fromJson(responseBody);
    } else {
      throw Exception('Failed to load detail healthy index from the Internet');
    }
  }

  Future<Map<String, dynamic>> deleteDetailHealthyIndex(
      DetailHealthyIndex detailHealthyIndex) async {
    Map<String, dynamic> result;

    Response response = await delete(
      Uri.parse(AppUrl.deleteDetailHealthyIndex + detailHealthyIndex.id!),
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
