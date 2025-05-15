import '../../utilities/Birthday.dart';
import '../../utilities/calculator.dart';
import '../../utilities/constants.dart';
import 'package:flutter/material.dart';

class BirthdayCardIcon extends StatefulWidget {
  final Birthday birthday;

  const BirthdayCardIcon(this.birthday, {Key? key}) : super(key: key);

  @override
  State<BirthdayCardIcon> createState() => _BirthdayCardIconState();
}

class _BirthdayCardIconState extends State<BirthdayCardIcon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        birthdayIcon(),
        ageText(),
      ],
    );
  }

  Icon birthdayIcon() {
    return const Icon(
      Icons.cake_outlined,
      size: 30,
      color: Constants.whiteSecondary,
    );
  }

  Text ageText() {
    return Text(
      getAge(),
      style: const TextStyle(
        fontSize: Constants.biggerFontSize,
        fontWeight: FontWeight.bold,
        color: Constants.whiteSecondary,
      ),
    );
  }

  String getAge() {
    String ageToday = '${Calculator.calculateAge(widget.birthday.date)}';
    String ageNext = '${Calculator.calculateAge(widget.birthday.date) + 1}';
    bool hasBirthday = Calculator.hasBirthdayToday(widget.birthday.date);
    return hasBirthday ? ageToday : ageNext;
  }
}
