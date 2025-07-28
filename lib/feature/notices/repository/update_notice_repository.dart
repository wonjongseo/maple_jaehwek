// update_notice_repository.dart
import 'dart:convert';
import 'package:every_maple/core/constants/api_url.dart';
import 'package:every_maple/core/network/dio_client.dart';
import 'package:every_maple/feature/notices/models/notice.dart';
import 'package:http/http.dart' as http;

class UpdateNoticeRepository {
  /// 예: {{baseUrl}}/maplestory/v1/notice-update
  DioClient _dioClient;
  UpdateNoticeRepository(this._dioClient);

  Future<List<Notice>> fetchUpdateNotices() async {
    final res = await _dioClient.get(ApiUrl.getUpdateNotices);
    if (res.statusCode != 200) {
      throw Exception('[${res.statusCode}] 업데이트 공지를 가져오지 못했습니다.');
    }

    final list = res.data['update_notice'] as List<dynamic>;
    return Notice.listFromJson(list);
  }
}
