import 'dart:async';

import 'birthday_card_countdown.dart';
import 'birthday_card_icon.dart';
import 'birthday_card_info.dart';
import '../../screens/birthday_info_page.dart';
import '../../utilities/Birthday.dart';
import '../../utilities/calculator.dart';
import '../../utilities/constants.dart';
import 'package:flutter/material.dart';

class BirthdayCard extends StatefulWidget {
  final Birthday birthday;
  final bool canTap;

  const BirthdayCard(this.birthday, this.canTap, {super.key});

  @override
  State<BirthdayCard> createState() => _BirthdayCardState();
}

class _BirthdayCardState extends State<BirthdayCard>
    with WidgetsBindingObserver {
  late Timer timer;
  late Duration duration;

  void startTimer() {
    duration = Duration(
      hours: Calculator.hoursTillBirthday(widget.birthday.date),
      minutes: Calculator.minutesTillBirthday(widget.birthday.date),
      seconds: Calculator.secondsTillBirthday(widget.birthday.date),
    );

    timer = Timer.periodic(
      duration,
      (Timer t) => mounted
          ? setState(() {
              duration = const Duration(hours: 24);
            })
          : timer.cancel(),
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
    return GestureDetector(
      onTap: () async {
        await onCardTap(context);
      },
      child: Container(
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          color: Constants.greySecondary,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BirthdayCardIcon(widget.birthday),
            const SizedBox(width: 15),
            BirthdayCardInfo(widget.birthday),
            const Spacer(),
            BirthdayCardCountdown(widget.birthday),
            rightArrow(),
          ],
        ),
      ),
    );
  }

  Future<void> onCardTap(BuildContext context) async {
    if (widget.canTap) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return BirthdayInfoPage(widget.birthday.birthdayId);
          },
        ),
      );
    }
  }

  Container rightArrow() {
    return Container(
      padding: const EdgeInsets.only(left: 10.0),
      child: widget.canTap
          ? const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Constants.whiteSecondary,
              size: 20,
            )
          : null,
    );
  }
}
