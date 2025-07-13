import 'package:every_maple/feature/notice/models/notice_model.dart';

class EventModel extends NoticeModel {
  // String? title;
  // String? url;
  // int? noticeId;
  // String? date;
  String? dateEventStart;
  String? dateEventEnd;

  EventModel(
      {String? title,
      String? url,
      int? noticeId,
      String? date,
      this.dateEventStart,
      this.dateEventEnd})
      : super(title: title, url: url, noticeId: noticeId, date: date);

  EventModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    noticeId = json['notice_id'];
    date = json['date'];
    dateEventStart = json['date_event_start'];
    dateEventEnd = json['date_event_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = super.title;
    data['url'] = super.url;
    data['notice_id'] = super.noticeId;
    data['date'] = super.date;
    data['date_event_start'] = this.dateEventStart;
    data['date_event_end'] = this.dateEventEnd;
    return data;
  }
}
