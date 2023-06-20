import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:per_note/models/healthy_index_model.dart';
import '../config/app_url_config.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class HealthyIndexRepository {
  Future<HealthyIndex> createNewHealthyIndex(
      String name, String unit, File? imageFile) async {
    var stream =
        imageFile != null ? http.ByteStream(imageFile.openRead()) : null;
    if (imageFile != null) stream?.cast();
    var length = imageFile != null ? await imageFile.length() : 0;

    var uri = Uri.parse(AppUrl.createNewHealthyIndex);

    var request = http.MultipartRequest("POST", uri);
    var multipartFile = imageFile != null
        ? http.MultipartFile('image', stream!, length,
            filename: basename(imageFile.path),
            contentType: MediaType('image', 'png'))
        : null;

    request.fields["name"] = name;
    request.fields["unit"] = unit;
    if (imageFile != null) request.files.add(multipartFile!);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    final responseBody = json.decode(response.body);

    final HealthyIndex healthyIndex =
        HealthyIndex.fromJson(responseBody['healthyIndex']);
    return healthyIndex;
  }

  Future<List<HealthyIndex>> getHealthyIndexList() async {
    Response response = await get(
      Uri.parse(AppUrl.getAllHealthyIndexs),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['healthy_indexs'];
      return jsonResponse
          .map((healthyIndex) => HealthyIndex.fromJson(healthyIndex))
          .toList();
    } else {
      throw Exception('Failed to load healthy index from the Internet');
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
    File file = File('$tempPath${rng.nextInt(100)}.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }
}
