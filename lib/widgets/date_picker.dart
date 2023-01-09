import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? date;
  TimeOfDay? time;

  String getTextDate() {
    if (date == null) {
      return 'select date';
    } else {
      return '${date?.day}/${date?.month}/${date?.year}';
    }
  }

  String getTextTime() {
    if (time == null) {
      return 'select Time';
    } else {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');
      var period = time!.period.toString();
      period = period.substring(10, 12).toUpperCase();

      return '$hours $period : $minutes min';
    }
  }

  Future pickDate(BuildContext context) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
    );

    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }

  Future pickTime(BuildContext context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (newTime != null && newTime != TimeOfDay.now()) {
      setState(() {
        time = newTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(
              Icons.calendar_month,
              size: 30,
            ),
            ElevatedButton(
              child: Text(getTextDate()),
              onPressed: (() => pickDate(context)),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timelapse_outlined,
                size: 30,
              ),
              ElevatedButton(
                child: Text(getTextTime()),
                onPressed: (() => pickTime(context)),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
