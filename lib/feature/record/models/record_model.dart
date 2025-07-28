// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:hive/hive.dart';

part 'record_model.g.dart'; // build_runner로 자동 생성

@HiveType(typeId: 0)
class RecordModel extends HiveObject {
  @HiveField(0)
  DateTime dateTime;

  @HiveField(1)
  int crystalJamCnt;

  @HiveField(2)
  int solErdaFragmentCnt;

  @HiveField(3)
  int meso;

  RecordModel({
    required this.dateTime,
    required this.crystalJamCnt,
    required this.solErdaFragmentCnt,
    required this.meso,
  });

  RecordModel copyWith({
    DateTime? dateTime,
    int? crystalJamCnt,
    int? solErdaFragmentCnt,
    int? meso,
  }) {
    return RecordModel(
      dateTime: dateTime ?? this.dateTime,
      crystalJamCnt: crystalJamCnt ?? this.crystalJamCnt,
      solErdaFragmentCnt: solErdaFragmentCnt ?? this.solErdaFragmentCnt,
      meso: meso ?? this.meso,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'crystalJamCnt': crystalJamCnt,
      'solErdaFragmentCnt': solErdaFragmentCnt,
      'meso': meso,
    };
  }

  factory RecordModel.fromMap(Map<String, dynamic> map) {
    return RecordModel(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      crystalJamCnt: map['crystalJamCnt'] as int,
      solErdaFragmentCnt: map['solErdaFragmentCnt'] as int,
      meso: map['meso'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecordModel.fromJson(String source) =>
      RecordModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RecordModel(dateTime: $dateTime, crystalJamCnt: $crystalJamCnt, solErdaFragmentCnt: $solErdaFragmentCnt, meso: $meso)';
  }

  @override
  bool operator ==(covariant RecordModel other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime &&
        other.crystalJamCnt == crystalJamCnt &&
        other.solErdaFragmentCnt == solErdaFragmentCnt &&
        other.meso == meso;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^
        crystalJamCnt.hashCode ^
        solErdaFragmentCnt.hashCode ^
        meso.hashCode;
  }
}
