// notice_model.dart
import 'package:meta/meta.dart';

@immutable
class Notice {
  final String title;
  final String url;
  final int noticeId;
  final DateTime date;

  // ───── 이벤트 전용 ─────
  final DateTime? eventStart;
  final DateTime? eventEnd;

  // ───── 캐시아이템 전용 ─────
  final DateTime? saleStart;
  final DateTime? saleEnd;
  final bool? ongoing; // true = 상시 판매중

  const Notice({
    required this.title,
    required this.url,
    required this.noticeId,
    required this.date,
    this.eventStart,
    this.eventEnd,
    this.saleStart,
    this.saleEnd,
    this.ongoing,
  });

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
        title: json['title'] as String,
        url: json['url'] as String,
        noticeId: json['notice_id'] as int,
        date: DateTime.parse(json['date'] as String),

        // 이벤트
        eventStart: _tryParse(json['date_event_start']),
        eventEnd: _tryParse(json['date_event_end']),

        // 캐시아이템
        saleStart: _tryParse(json['date_sale_start']),
        saleEnd: _tryParse(json['date_sale_end']),
        ongoing: json['ongoing_flag'] != null
            ? (json['ongoing_flag'] as String).toLowerCase() == 'true'
            : null,
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'url': url,
        'notice_id': noticeId,
        'date': date.toIso8601String(),
        if (eventStart != null)
          'date_event_start': eventStart!.toIso8601String(),
        if (eventEnd != null) 'date_event_end': eventEnd!.toIso8601String(),
        if (saleStart != null) 'date_sale_start': saleStart!.toIso8601String(),
        if (saleEnd != null) 'date_sale_end': saleEnd!.toIso8601String(),
        if (ongoing != null) 'ongoing_flag': ongoing.toString(),
      };

  static List<Notice> listFromJson(List<dynamic> list) =>
      list.map((e) => Notice.fromJson(e as Map<String, dynamic>)).toList();

  /* ────────────────────────────────────────────────────────────── */
  static DateTime? _tryParse(dynamic value) =>
      (value == null) ? null : DateTime.tryParse(value as String);
}
