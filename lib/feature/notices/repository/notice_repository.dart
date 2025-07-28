// notice_repository.dart
import 'dart:convert';
import 'package:every_maple/core/constants/api_url.dart';
import 'package:every_maple/core/network/dio_client.dart';
import 'package:every_maple/feature/notices/models/notice.dart';
import 'package:http/http.dart' as http;

class NoticeRepository {
  DioClient _dioClient;
  NoticeRepository(this._dioClient);

  Future<List<Notice>> fetchNotices() async {
    final res = await _dioClient.get(ApiUrl.getNotices);
    if (res.statusCode != 200) {
      throw Exception('[${res.statusCode}] 공지 목록을 가져오지 못했습니다.');
    }

    final list = res.data['notice'] as List<dynamic>;
    return Notice.listFromJson(list);
  }

  Future<List<Notice>> fetchNotice(Notice notice) async {
    final res = await _dioClient.get(ApiUrl.getNoticeDetail,
        queryParameters: {"notice_id": notice.noticeId});

    if (res.statusCode != 200) {
      throw Exception('[${res.statusCode}] 공지 목록을 가져오지 못했습니다.');
    }

    final list = res.data['notice'] as List<dynamic>;
    return Notice.listFromJson(list);
  }

  // Update

  Future<List<Notice>> fetchUpdateNotices() async {
    final res = await _dioClient.get(ApiUrl.getUpdateNotices);
    if (res.statusCode != 200) {
      throw Exception('[${res.statusCode}] 업데이트 공지를 가져오지 못했습니다.');
    }

    final list = res.data['update_notice'] as List<dynamic>;
    return Notice.listFromJson(list);
  }

  ///
  ///
  Future<List<Notice>> fetchEventNotices() async {
    final res = await _dioClient.get(ApiUrl.getNoticeEvents);
    if (res.statusCode != 200) {
      throw Exception('[${res.statusCode}] 이벤트 공지를 가져오지 못했습니다.');
    }

    final list = res.data['event_notice'] as List<dynamic>;
    return Notice.listFromJson(list);
  }

  /// Cash
  Future<List<Notice>> fetchCashShopNotices() async {
    final res = await _dioClient.get(ApiUrl.getCashEvents);
    if (res.statusCode != 200) {
      throw Exception('[${res.statusCode}] 캐시아이템 공지를 가져오지 못했습니다.');
    }

    final list = res.data['cashshop_notice'] as List<dynamic>;
    return Notice.listFromJson(list);
  }
}
