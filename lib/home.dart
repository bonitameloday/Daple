import 'package:google_map/diary/pages/diary.dart';
import 'package:google_map/diary/pages/edit.dart';
import 'package:google_map/planner/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'diary/pages/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now(); // 추가: 선택된 날짜를 저장하는 변수

  @override
  void initState() {
    initializeDateFormatting('ko-KR');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Container(
                child: TableCalendar(
                  firstDay: DateTime.utc(2000, 1, 1),
                  lastDay: DateTime.utc(2999, 12, 31),
                  focusedDay: DateTime.now(),
                  locale: 'ko-KR',
                  daysOfWeekHeight: 30,
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronVisible: true,
                    rightChevronVisible: true,
                  ),
                  // 추가: 날짜 선택 콜백
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      this.selectedDate = selectedDay;
                    });
                  },
                  selectedDayPredicate: (day) {
                    // 선택된 날짜 표시를 위한 조건
                    return isSameDay(selectedDate, day);
                  },
                ),
              ),
              // 추가: 선택된 날짜 표시
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => EditPage(selectedDate: this.selectedDate),
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.lightGreen,
        ),
      ),
    );
  }
}
