import 'package:intl/intl.dart';

DateTime date = new DateTime.now();
List days = [
  {
    "label": DateFormat('EEEE').format(date.subtract(new Duration(days: 3))),
    "day": date.subtract(new Duration(days: 3)).day.toString()
  },
  {
    "label": DateFormat('EEEE').format(date.subtract(new Duration(days: 2))),
    "day": date.subtract(new Duration(days: 2)).day.toString()
  },
  {
    "label": DateFormat('EEEE').format(date.subtract(new Duration(days: 1))),
    "day": date.subtract(new Duration(days: 1)).day.toString()
  },
  {"label": DateFormat('EEEE').format(date), "day": date.day.toString()},
  {
    "label": DateFormat('EEEE').format(date.add(new Duration(days: 1))),
    "day": date.add(new Duration(days: 1)).day.toString()
  },
  {
    "label": DateFormat('EEEE').format(date.add(new Duration(days: 2))),
    "day": date.add(new Duration(days: 2)).day.toString()
  },
  {
    "label": DateFormat('EEEE').format(date.add(new Duration(days: 3))),
    "day": date.add(new Duration(days: 3)).day.toString()
  },
];
