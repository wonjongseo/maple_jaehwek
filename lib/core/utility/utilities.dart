import 'package:get/get.dart';
import 'package:intl/intl.dart';

String getCurrentDate() {
  DateTime now = DateTime.now();
  return DateFormat('yyyy-MM-dd').format(now);
}

String dateToYYYYMMDD(DateTime date) {
  return DateFormat.yMMMd().format(date);
}
