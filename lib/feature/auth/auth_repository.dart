import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:every_maple/core/constants/api_url.dart';
import 'package:every_maple/core/network/dio_client.dart';
import 'package:every_maple/feature/auth/models/char_model.dart';
import 'package:get/get.dart';

class AuthRepository {
  Future<String?> fetchUserByCharName({required String charName}) async {
    try {
      var response = await Get.find<DioClient>()
          .get(ApiUrl.getUserIdByCharName, queryParameters: {
        'character_name': charName,
      });

      if (response.statusCode == 200) {
        return response.data['ocid'];
      }
    } on DioException catch (e) {
      log(e.response!.data);
    }

    // restApiClient
    //     .get(getCharByIdUrl, queryParameters: {'character_name': charName});
  }

  Future<CharModel?> fetchCharDetailByUid({required String uId}) async {
    try {
      final response = await Get.find<DioClient>()
          .get(ApiUrl.characterDetailByUid, queryParameters: {
        'ocid': uId,
      });
      if (response.statusCode == 200) {
        return CharModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      log(e.toString());
    }
  }
}
