// notice_controller.dart
import 'package:every_maple/core/enums/enums.dart';
import 'package:every_maple/feature/notices/models/notice.dart';
import 'package:every_maple/feature/notices/repository/notice_repository.dart';
import 'package:get/get.dart';

class NoticeController extends GetxController {
  final NoticeRepository _repo;
  NoticeController(this._repo);

  List<Notice> get notices {
    switch (selectedNoticeType.value) {
      case NoticeType.eventNotices:
        return _events;
      case NoticeType.notices:
        return _notices;
      case NoticeType.updateNotices:
        return _updates;
      case NoticeType.cashNotices:
        return _cashs;
    }
  }

  /// Notices
  final RxList<Notice> _notices = <Notice>[].obs;

  /// Update
  final RxList<Notice> _updates = <Notice>[].obs;

  /// event
  final RxList<Notice> _events = <Notice>[].obs;

  /// cash
  final RxList<Notice> _cashs = <Notice>[].obs;

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final selectedNoticeType = NoticeType.eventNotices.obs;

  void changeNoticeType(NoticeType type) {
    selectedNoticeType.value = type;
  }

  @override
  void onInit() {
    super.onInit();
    fetchNotices();
    fetchUpdateNotices();
    fetchEventNotices();
    fetchCashShopNotices();
  }

  Future<void> fetchNotices() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repo.fetchNotices();
      _notices.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchNotice(Notice notice) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repo.fetchNotices();
      _notices.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUpdateNotices() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repo.fetchUpdateNotices();
      _updates.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchEventNotices() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repo.fetchEventNotices();
      _events.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCashShopNotices() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repo.fetchCashShopNotices();
      _cashs.assignAll(result);
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
