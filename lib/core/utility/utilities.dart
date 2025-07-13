import 'package:intl/intl.dart';

String getCurrentDate() {
  DateTime now = DateTime.now();
  return DateFormat('yyyy-MM-dd').format(now);
}
