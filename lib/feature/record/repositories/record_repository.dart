import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import '../models/record_model.dart';

class RecordRepository {
  final Box<RecordModel> _box;
  RecordRepository(this._box);

  /* key 포맷: yyyy-MM-dd */
  String _key(DateTime d) => DateFormat('yyyy-MM-dd').format(d);

  RecordModel? fetchByDate(DateTime d) => _box.get(_key(d));

  Map<DateTime, RecordModel> fetchAll() {
    final map = <DateTime, RecordModel>{};
    for (var r in _box.values) {
      final k = DateTime(r.dateTime.year, r.dateTime.month, r.dateTime.day);
      map[k] = r;
    }
    return map;
  }

  Future<void> upsert(RecordModel record) =>
      _box.put(_key(record.dateTime), record);

  ValueListenable<Box<RecordModel>> listenable() => _box.listenable();
}
