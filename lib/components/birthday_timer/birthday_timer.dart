import 'dart:async';

import 'birthday_timer_counter.dart';
import '../../utilities/birthday_data.dart';
import '../../utilities/calculator.dart';
import '../../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthdayTimer extends StatefulWidget {
  final int birthdayId;

  const BirthdayTimer(this.birthdayId, {Key? key}) : super(key: key);

  @override
  State<BirthdayTimer> createState() => _BirthdayTimerState();
}

class _BirthdayTimerState extends State<BirthdayTimer>
    with WidgetsBindingObserver {
  late Timer timer;
  Duration duration = const Duration(milliseconds: 100);

  void startTimer() {
    timer = Timer.periodic(
      duration,
      (Timer t) => mounted ? setState(() {}) : timer.cancel(),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        timer.cancel();
        break;
      case AppLifecycleState.inactive:
        timer.cancel();
        break;
      case AppLifecycleState.resumed:
        timer = Timer.periodic(duration, (Timer t) => setState(() {}));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.darkGreySecondary,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 15,
          bottom: 5,
        ),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.countdown,
              style: const TextStyle(
                color: Constants.whiteSecondary,
                fontSize: Constants.biggerFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
            countdownContainer(),
          ],
        ),
      ),
    );
  }

  Widget countdownContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        BirthdayTimerCounter(
          AppLocalizations.of(context)!.days,
          Calculator.daysTillBirthday(getDataById(widget.birthdayId).date),
        ),
        BirthdayTimerCounter(
          AppLocalizations.of(context)!.hours,
          Calculator.hoursTillBirthday(getDataById(widget.birthdayId).date),
        ),
        BirthdayTimerCounter(
          AppLocalizations.of(context)!.minutes,
          Calculator.minutesTillBirthday(getDataById(widget.birthdayId).date),
        ),
        BirthdayTimerCounter(
          AppLocalizations.of(context)!.seconds,
          Calculator.secondsTillBirthday(getDataById(widget.birthdayId).date),
        ),
      ],
    );
  }
}
