import 'package:every_maple/feature/record/repositories/record_repository.dart';
import 'package:get/get.dart';
import '../models/record_model.dart';

class RecordController extends GetxController {
  final RecordRepository repo;
  RecordController(this.repo);

  /// 날짜 → Record 맵 (RxMap)
  final RxMap<DateTime, RecordModel> records = <DateTime, RecordModel>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _refresh();
    repo.listenable().addListener(_refresh);
  }

  void _refresh() => records.assignAll(repo.fetchAll());

  RecordModel? recordOf(DateTime date) =>
      records[DateTime(date.year, date.month, date.day)];

  Future<void> save(RecordModel record) async => repo.upsert(record);

  @override
  void onClose() {
    repo.listenable().removeListener(_refresh);
    super.onClose();
  }
}
