class NoticeModel {
  String? title;
  String? url;
  int? noticeId;
  String? date;

  NoticeModel({this.title, this.url, this.noticeId, this.date});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    noticeId = json['notice_id'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    data['notice_id'] = this.noticeId;
    data['date'] = this.date;
    return data;
  }
}
