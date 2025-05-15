import '../../utilities/Birthday.dart';
import '../../utilities/calculator.dart';
import '../../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthdayCardCountdown extends StatefulWidget {
  final Birthday birthday;

  const BirthdayCardCountdown(this.birthday, {Key? key}) : super(key: key);

  @override
  State<BirthdayCardCountdown> createState() => _BirthdayCardCountdownState();
}

class _BirthdayCardCountdownState extends State<BirthdayCardCountdown> {
  @override
  Widget build(BuildContext context) {
    return Calculator.hasBirthdayToday(widget.birthday.date)
        ? partyIcon()
        : dayCounter();
  }

  Container partyIcon() {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.purplePrimary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Constants.purplePrimary,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      width: 60,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Text(
            '🎉',
            style: TextStyle(
              fontSize: Constants.titleFontSize,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Constants.blackPrimary,
                  offset: Offset(0.3, 0.2),
                  blurRadius: 15.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container dayCounter() {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.purpleSecondary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Constants.purpleSecondary,
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      width: 60,
      height: 60,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            Calculator.remainingDaysTillBirthday(widget.birthday.date)
                .toString(),
            style: const TextStyle(
                fontSize: Constants.normalFontSize,
                fontWeight: FontWeight.bold,
                color: Constants.whiteSecondary),
          ),
          Text(
            AppLocalizations.of(context)!.days,
            style: const TextStyle(
              fontSize: Constants.smallerFontSize,
              fontWeight: FontWeight.bold,
              color: Constants.whiteSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
