import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myapp/models/task_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/rdplogo.png', height: 80),
            SizedBox(width: 100),
            Text('Daily Planner', style: TextStyle(fontFamily: 'Caveat', fontSize: 32, color: Colors.white))
          ],
        )
      ),
      drawer: Drawer(),
      body: 
      Column(children: [
        TableCalendar(
          calendarFormat: CalendarFormat.month,
          focusedDay: DateTime.now(),
          firstDay: DateTime(2026),
          lastDay: DateTime(2027)
        ),
      ])
    );
  }
}