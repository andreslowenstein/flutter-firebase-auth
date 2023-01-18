import 'package:dio/dio.dart';

class Service {
  Future<String> getMeme() async {
    try {
      var response = await Dio().get('https://meme-api.com/gimme');
      final url = response.data["url"];
      return url;
    } catch (e) {
      throw e;
    }
  }
}
