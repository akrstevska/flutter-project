import '../utilities/constants.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final TimeOfDay startTime;

  const TimePicker(this.startTime, {Key? key, this.onTimeChanged})
      : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.timer_outlined),
            const SizedBox(width: 10),
            Text(
              widget.startTime.format(context),
              style: const TextStyle(fontSize: Constants.normalFontSize),
            ),
          ],
        ),
        onPressed: () {
          _selectTime(context);
        },
      ),
    );
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: widget.startTime,
      initialEntryMode: TimePickerEntryMode.dialOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            timePickerTheme: const TimePickerThemeData(
              dayPeriodTextColor: Constants.whiteSecondary,
              dayPeriodBorderSide: BorderSide(color: Constants.purpleSecondary),
              dialHandColor: Constants.purpleSecondary,
              dialTextColor: Constants.whiteSecondary,
              entryModeIconColor: Constants.whiteSecondary,
              hourMinuteTextColor: Constants.whiteSecondary,
              helpTextStyle: TextStyle(color: Constants.whiteSecondary),
              hourMinuteColor: Constants.greySecondary,
              backgroundColor: Constants.darkGreySecondary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedTime != null && selectedTime != widget.startTime) {
      setState(() {
        widget.onTimeChanged!(selectedTime);
      });
    }
  }
}
