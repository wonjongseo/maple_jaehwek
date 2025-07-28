enum NoticeType {
  eventNotices("이벤트"),
  notices("공지사항"),
  updateNotices("업데이트"),
  cashNotices("캐시샵");

  final String label;
  const NoticeType(this.label);
}
