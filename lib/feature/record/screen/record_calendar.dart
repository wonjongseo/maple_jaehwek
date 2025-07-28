import 'package:every_maple/feature/record/screen/record_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../controllers/record_controller.dart';
import '../models/record_model.dart';

class RecordCalendarView extends GetView<RecordController> {
  const RecordCalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final events = Map<DateTime, RecordModel>.from(controller.records);

        List<RecordModel> eventsFor(DateTime d) {
          final key = DateTime(d.year, d.month, d.day);
          final rec = events[key];
          return rec == null ? const [] : [rec];
        }

        return SafeArea(
          child: TableCalendar<RecordModel>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: DateTime.now(),
            calendarFormat: CalendarFormat.month,
            shouldFillViewport: true,
            headerStyle: HeaderStyle(
              titleCentered: true,
            ),
            eventLoader: eventsFor,
            onDaySelected: (selected, _) => Get.to(
              () => RecordFormView(date: selected),
            ),
          ),
        );
      }),
    );
  }
}
