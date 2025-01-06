import 'package:flutter/material.dart';
import 'package:lab4/screens/main.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(ExamScheduleApp());
}

class ExamScheduleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exam Schedule',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ExamSchedulePage(),
    );
  }
}

class ExamSchedulePage extends StatefulWidget {
  @override
  _ExamSchedulePageState createState() => _ExamSchedulePageState();
}

class _ExamSchedulePageState extends State<ExamSchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDate = DateTime.now();
  DateTime _focusedDate = DateTime.now();

  Map<DateTime, List<Map<String, String>>> _examSchedule = {
    DateTime(2025, 1, 10): [
      {'time': '10:00 AM', 'location': 'Room 101'},
    ],
    DateTime(2025, 1, 15): [
      {'time': '2:00 PM', 'location': 'Room 202'},
    ],
  };

  List<Map<String, String>> _getEventsForDay(DateTime day) {
    return _examSchedule[DateTime(day.year, day.month, day.day)] ?? [];
  }

  void _addExamSchedule(DateTime date, String time, String location) {
    setState(() {
      final key = DateTime(date.year, date.month, date.day);
      if (_examSchedule[key] == null) {
        _examSchedule[key] = [];
      }
      _examSchedule[key]!.add({'time': time, 'location': location});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: ListTile(
            title: Center(
              child: Text("Go to Maps"),
            ),

            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MapSample()));
            },
          )
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _focusedDate,
            firstDay: DateTime(2020),
            lastDay: DateTime(2030),
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
                _focusedDate = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDate = focusedDay;
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: ListView.builder(
              itemCount: _getEventsForDay(_selectedDate).length,
              itemBuilder: (context, index) {
                final event = _getEventsForDay(_selectedDate)[index];
                return ListTile(
                  title: Text('Time: ${event['time']}'),
                  subtitle: Text('Location: ${event['location']}'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddExamDialog(),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddExamDialog() {
    final _timeController = TextEditingController();
    final _locationController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Exam Schedule'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time (e.g., 10:00 AM)'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (_timeController.text.isNotEmpty &&
                  _locationController.text.isNotEmpty) {
                _addExamSchedule(_selectedDate, _timeController.text,
                    _locationController.text);
                Navigator.of(context).pop();
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }
}
