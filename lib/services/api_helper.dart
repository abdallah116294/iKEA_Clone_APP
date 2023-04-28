import 'dart:typed_data';
import 'package:ar_furniture_app/constant.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future<Uint8List> removeImageBackgroubdApi(String imagePath) async {
    var requestApi = await http.MultipartRequest(
        "POST", Uri.parse('https://api.remove.bg/v1.0/removebg'));
    requestApi.files
        .add(await http.MultipartFile.fromPath('image_file', imagePath));
    requestApi.headers.addAll({"X-API-Key": apiKey});
    final response = await requestApi.send();
    if (response.statusCode == 200) {
      http.Response getTransparentImageFromResponse =
          await http.Response.fromStream(response);
      return getTransparentImageFromResponse.bodyBytes;
    } else {
      throw Exception('Error' + response.statusCode.toString());
    }
  }
}
