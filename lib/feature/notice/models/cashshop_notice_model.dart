import 'package:every_maple/feature/notice/models/notice_model.dart';

class CashshopNoticeModel extends NoticeModel {
  String? dateSaleStart;
  String? dateSaleEnd;
  String? ongoingFlag;

  CashshopNoticeModel(
      {String? title,
      String? url,
      int? noticeId,
      String? date,
      this.dateSaleStart,
      this.dateSaleEnd,
      this.ongoingFlag})
      : super(title: title, url: url, noticeId: noticeId, date: date);

  CashshopNoticeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    noticeId = json['notice_id'];
    date = json['date'];
    dateSaleStart = json['date_sale_start'];
    dateSaleEnd = json['date_sale_end'];
    ongoingFlag = json['ongoing_flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = super.title;
    data['url'] = super.url;
    data['notice_id'] = super.noticeId;
    data['date'] = super.date;
    data['date_sale_start'] = this.dateSaleStart;
    data['date_sale_end'] = this.dateSaleEnd;
    data['ongoing_flag'] = this.ongoingFlag;
    return data;
  }
}
