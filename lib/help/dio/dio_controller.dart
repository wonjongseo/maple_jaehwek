import 'package:dio/dio.dart';
import 'package:every_maple/core/constants/api_url.dart';

// String baseUrl = "http://open.api.nexon.com";

String getCharByIdUrl = '';
Map<String, String> requireHeader = {ApiUrl.headerKey: ApiUrl.headerValue};

class DioController {
  static final dio = Dio();

  static getCharIdByName({required String charName}) async {
    try {
      final response = await dio.get(
        ApiUrl.baseURL + getCharByIdUrl,
        queryParameters: {'character_name': charName},
        options: Options(headers: requireHeader),
      );
      print(response);
    } catch (e) {
      print('e.toString : ${e.toString()}');
    }
  }
}
