import 'package:every_maple/feature/record/screen/edit_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});
  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  // 1) 캘린더 컨트롤 변수
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  // 2) 날짜별 이벤트 데이터 (예시)
  final Map<DateTime, List<String>> _events = {
    DateTime.utc(2025, 7, 10): ['회의', '친구 생일'],
    DateTime.utc(2025, 7, 15): ['Flutter 스터디'],
  };

  // 3) 해당 날짜 이벤트 반환 함수
  List<String> _getEventsForDay(DateTime day) {
    return _events[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: TableCalendar<String>(
                shouldFillViewport: true,
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                eventLoader: _getEventsForDay,
                calendarFormat: CalendarFormat.month,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay; // 포커스 이동
                  });

                  Get.to(() => const EditRecordScreen());
                },
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blueAccent,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),

            // 5) 선택된 날짜의 이벤트 리스트 표시
            // Expanded(
            //   child: ListView(
            //     children: _getEventsForDay(_selectedDay ?? _focusedDay)
            //         .map((event) => ListTile(
            //               leading: const Icon(Icons.event),
            //               title: Text(event),
            //               trailing: Image.asset('assets/images/meso.png'),
            //             ))
            //         .toList(),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
