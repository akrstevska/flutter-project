import '../../utilities/constants.dart';
import 'package:flutter/material.dart';

class BirthdayTimerCounter extends StatefulWidget {
  final String unit;
  final int time;

  const BirthdayTimerCounter(this.unit, this.time, {Key? key})
      : super(key: key);

  @override
  State<BirthdayTimerCounter> createState() => _BirthdayTimerCounterState();
}

class _BirthdayTimerCounterState extends State<BirthdayTimerCounter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        children: [
          Text(
            widget.time.toString(),
            style: const TextStyle(
              color: Constants.whiteSecondary,
              fontSize: Constants.biggerFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            widget.unit,
            style: const TextStyle(
              color: Constants.whiteSecondary,
            ),
          )
        ],
      ),
    );
  }
}
