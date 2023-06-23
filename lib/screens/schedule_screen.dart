import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:per_note/config/theme.dart';
import 'package:per_note/screens/widgets/schedule_manage/task_list.dart';
import 'package:per_note/screens/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../services/notification_service.dart';

class ScheduleScreen extends StatefulWidget {
  static const String routeName = '/schedule';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => const ScheduleScreen(),
      settings: const RouteSettings(name: routeName),
    );
  }

  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  NotificationService notifyService = NotificationService();
  List<Task> tasks = [];
  DateTime _selectedDate = DateTime.now();
  CalendarFormat _selectedCalendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  bool _isTableCalendar = false;

  @override
  void initState() {
    super.initState();
    notifyService.initializeNotification(selectNotification);
    notifyService.requestIOSPermissions();
  }

  selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    } else {
      debugPrint('Notification Done');
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return NotificationScreen(payload: payload!);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 251, 248, 248),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black38),
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          'Lập kế hoạch',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isTableCalendar = !_isTableCalendar;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.calendar_month_outlined,
                size: 30,
                color: _isTableCalendar ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _addTaskBar(),
          _isTableCalendar ? _addCalendarView() : _addDateBar(),
          const SizedBox(height: 10),
          _showTasks(),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  _showTasks() {
    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);

    return Expanded(
      child: FutureBuilder<List<Task>>(
        future: taskProvider.getTasksList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return snapshot.hasData
              ? TaskList(tasks: snapshot.data!, selectedDate: _selectedDate)
              : const Center(
                  child: ColorLoader(),
                );
        },
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.indigo[800]!,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        locale: 'vi_VN',
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('dd/MM/yyyy').format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                'Hôm nay',
                style: headingStyle,
              )
            ],
          ),
          RoundedButton(
            color: Colors.indigo[800],
            text: 'Add Task',
            onPressed: () {
              Navigator.pushNamed(context, AddTaskScreen.routeName)
                  .then((_) => setState(() {}));
            },
            width: 0.3,
          )
        ],
      ),
    );
  }

  List<Task> _getEventsForDay(DateTime day) {
    Map<DateTime, List<Task>> mySelectedEvents = {};

    TaskProvider taskProvider =
        Provider.of<TaskProvider>(context, listen: false);
    tasks = taskProvider.getTasks;

    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    for (var task in tasks) {
      DateTime date = dateFormat.parse(task.date!);
      mySelectedEvents[day] = [task];
      // if (task.repeat == 'Ngày') {
      //   if (mySelectedEvents[day] != null) {
      //     mySelectedEvents[day]?.add(task);
      //   } else {
      //     mySelectedEvents[day] = [task];
      //   }
      // }

      // if (task.repeat == 'Tuần') {
      //   int distance = daysBetween(date, day);
      //   if (distance % 7 == 0) {
      //     if (mySelectedEvents[day] != null) {
      //       mySelectedEvents[day]?.add(task);
      //     } else {
      //       mySelectedEvents[day] = [task];
      //     }
      //   }
      // }

      // if (day.day == date.day &&
      //     day.month == date.month &&
      //     day.year == day.year &&
      //     task.repeat != 'Ngày' &&
      //     task.repeat != 'Tuần') {
      //   if (mySelectedEvents[day] != null) {
      //     mySelectedEvents[day]?.add(task);
      //   } else {
      //     mySelectedEvents[day] = [task];
      //   }
      // }
    }
    return mySelectedEvents[day] ?? [];
  }

  _addCalendarView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Card(
        // margin: const EdgeInsets.all(8.0),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(color: blackCoffeeColor!, width: 1.0),
        ),
        child: TableCalendar(
          firstDay: DateTime.utc(2023, 6, 20),
          lastDay: DateTime.utc(2023, 8, 20),
          daysOfWeekHeight: 40.0,
          rowHeight: 60.0,
          focusedDay: _focusedDay,
          selectedDayPredicate: (day) {
            return isSameDay(_selectedDate, day);
          },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDate = selectedDay;
              _focusedDay = focusedDay;
            });
          },
          calendarFormat: _selectedCalendarFormat,
          onFormatChanged: (format) {
            setState(() {
              _selectedCalendarFormat = format;
            });
          },
          daysOfWeekStyle: const DaysOfWeekStyle(
            weekendStyle: TextStyle(color: Colors.red),
          ),
          weekendDays: const [DateTime.sunday],
          eventLoader: _getEventsForDay,
          headerStyle: HeaderStyle(
            titleTextStyle: TextStyle(color: whiteColor, fontSize: 20.0),
            decoration: BoxDecoration(
                color: tealColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            formatButtonTextStyle: TextStyle(color: redColor, fontSize: 16.0),
            formatButtonDecoration: BoxDecoration(
              color: whiteColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: whiteColor,
              size: 28,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: whiteColor,
              size: 28,
            ),
          ),
          calendarStyle: CalendarStyle(
            weekendTextStyle: TextStyle(color: redColor),
            todayDecoration: BoxDecoration(
              color: redColor200,
              shape: BoxShape.circle,
            ),
            markerDecoration: const BoxDecoration(
                color: Color.fromARGB(255, 11, 184, 54),
                shape: BoxShape.circle),
            selectedDecoration: BoxDecoration(
              color: redColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
