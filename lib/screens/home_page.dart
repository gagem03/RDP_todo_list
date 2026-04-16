import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myapp/models/task_model.dart';
import 'package:myapp/providers/task_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final input = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<TaskProvider>().load();
  }

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<TaskProvider>();
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
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: tp.tasks.length,
          itemBuilder: (context, i) {
            final task = tp.tasks[i];
            return ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              tileColor: i.isEven ? Colors.lightGreen : Colors.deepPurpleAccent,
              leading: Icon(task.completed ? Icons.check_circle : Icons.circle_outlined),
              title: Text(task.title.toString(), style: TextStyle(
                fontSize: 22,
                decoration: task.completed ? TextDecoration.lineThrough : null
              )),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    value: task.completed,
                    onChanged: (value) => tp.update(i, value!)
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => tp.delete(i),
                  ),
                ],
              )
            );
          }),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    maxLength: 32,
                    controller: input,
                    decoration: const InputDecoration(
                      labelText: 'Add Task',
                      border: OutlineInputBorder()
                    )
                  ),
                ),
                ElevatedButton(
                  child: Text('Add'),
                  onPressed: () => tp.add(input.text)
                )
              ]
                        ),
            )
      ])
    );
  }
}