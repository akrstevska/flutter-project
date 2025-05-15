import '../utilities/constants.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  final ValueChanged<DateTime>? onDayChanged;
  final DateTime startDay;

  const DatePicker(this.startDay, {Key? key, this.onDayChanged})
      : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.date_range_rounded),
            const SizedBox(width: 10),
            Text(
              '${widget.startDay.day}.${widget.startDay.month}.${widget.startDay.year}',
              style: const TextStyle(fontSize: Constants.normalFontSize),
            ),
          ],
        ),
        onPressed: () {
          _selectDate(context);
        },
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? selectedDay = await showDatePicker(
      context: context,
      initialDate: widget.startDay,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Constants.purpleSecondary,
              onPrimary: Constants.blackPrimary,
              onSurface: Constants.blackPrimary,
            ),
            dialogBackgroundColor: Constants.darkGreySecondary,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Constants.blackPrimary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDay != null && selectedDay != widget.startDay) {
      setState(() {
        widget.onDayChanged!(selectedDay);
      });
    }
  }
}
