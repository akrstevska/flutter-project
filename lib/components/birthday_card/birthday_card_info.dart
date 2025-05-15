import '../../utilities/Birthday.dart';
import '../../utilities/calculator.dart';
import '../../utilities/constants.dart';
import 'package:flutter/material.dart';

class BirthdayCardInfo extends StatefulWidget {
  final Birthday birthday;

  const BirthdayCardInfo(this.birthday, {Key? key}) : super(key: key);

  @override
  State<BirthdayCardInfo> createState() => _BirthdayCardInfoState();
}

class _BirthdayCardInfoState extends State<BirthdayCardInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        nameText(),
        infoText(),
      ],
    );
  }

  Text infoText() {
    return Text(
      getDateText(),
      style: const TextStyle(
        fontSize: Constants.smallerFontSize,
        color: Constants.whiteSecondary,
      ),
    );
  }

  Text nameText() {
    return Text(
      widget.birthday.name,
      style: const TextStyle(
        fontSize: Constants.biggerFontSize,
        fontWeight: FontWeight.bold,
        color: Constants.whiteSecondary,
      ),
    );
  }

  String getDateText() {
    String day = Calculator.getDayName(widget.birthday.date.weekday, context);
    String month = Calculator.getMonthName(widget.birthday.date.month, context);
    return '$day, ${widget.birthday.date.day}. $month';
  }
}
