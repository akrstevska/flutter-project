import 'dart:async';

import '../utilities/calculator.dart';
import '../utilities/constants.dart';
import 'package:flutter/material.dart';

class PreciseAge extends StatefulWidget {
  final DateTime date;
  const PreciseAge(this.date, {Key? key}) : super(key: key);

  @override
  State<PreciseAge> createState() => _PreciseAgeState();
}

class _PreciseAgeState extends State<PreciseAge> with WidgetsBindingObserver {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          Calculator.calculateAge(widget.date).toString(),
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.titleFontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          Calculator.calculatePreciseAge(widget.date, 8).toString(),
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.biggerFontSize,
          ),
        ),
      ],
    );
  }
}
