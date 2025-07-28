class ApiUrl {
  static const baseURL = 'http://open.api.nexon.com/';
  static const headerKey = 'x-nxopen-api-key';
  static const headerValue =
      'test_6aead9bae5146932c956d3b8870edbcaa78e17041c75487334b2c4ef993e0a48efe8d04e6d233bd35cf2fabdeb93fb0d';

  static const getUserIdByCharName = 'maplestory/v1/id';
  static const characterDetailByUid = 'maplestory/v1/character/basic';
  static const characterPopularityByUid = 'maplestory/v1/character/popularity';
  static const characterStatByUid = 'maplestory/v1/character/stat';

  static const rankingOfCharacter = 'maplestory/v1/ranking/overall';

/*
  {
  "notice": [
    {
      "title": "string",
      "url": "string",
      "notice_id": 0,
      "date": "2023-12-21T00:00+09:00"
    }
  ]
 */
  static const getNotices = '/maplestory/v1/notice';
  static const getNoticeDetail = '/maplestory/v1/notice/detail';

  static const getUpdateNotices = '/maplestory/v1/notice-update';
  static const getUpdateNotice = '/maplestory/v1/notice/detail';

  static const getNoticeEvents = '/maplestory/v1/notice-event';
  static const getNoticeEvent = '/maplestory/v1/notice/detail';

  static const getCashEvents = '/maplestory/v1/notice-cashshop';
  static const getCashEvent = '/maplestory/v1/notice/detail';

  static const getEvnets = '/maplestory/v1/notice-event';
//
}
