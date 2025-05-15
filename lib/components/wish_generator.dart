import 'dart:math';

import '../../utilities/Birthday.dart';
import '../utilities/calculator.dart';
import '../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WishGenerator extends StatefulWidget {
  final Birthday birthday;
  const WishGenerator(this.birthday, {Key? key}) : super(key: key);

  @override
  State<WishGenerator> createState() => _WishGeneratorState();
}

class _WishGeneratorState extends State<WishGenerator> {
  String birthdayWish = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 40, left: 40, top: 20),
      child: Container(
        decoration: const BoxDecoration(
          color: Constants.darkGreySecondary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              wishText(),
              actionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Expanded wishText() {
    birthdayWish = getNewWish(birthdayWish);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          birthdayWish,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.smallerFontSize,
          ),
        ),
      ),
    );
  }

  Padding actionButtons() {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await Clipboard.setData(
                ClipboardData(text: birthdayWish),
              );
            },
            child: const Icon(Icons.copy),
          ),
          refreshButton(),
        ],
      ),
    );
  }

  ElevatedButton refreshButton() {
    return ElevatedButton(
      onPressed: (() {
        setState(() {});
      }),
      child: const Icon(Icons.refresh),
    );
  }

  String getNewWish(String oldWish) {
    String newWish = getWish();

    while (newWish == oldWish) {
      newWish = getWish();
    }

    return newWish;
  }

  String getWish() {
    List<String> wishes = [
      AppLocalizations.of(context)!.wish1,
      AppLocalizations.of(context)!.wish2,
      AppLocalizations.of(context)!.wish3,
      AppLocalizations.of(context)!.wish4,
      AppLocalizations.of(context)!.wish5,
      AppLocalizations.of(context)!.wish6,
      AppLocalizations.of(context)!.wish7,
      AppLocalizations.of(context)!.wish8,
      AppLocalizations.of(context)!.wish9,
      AppLocalizations.of(context)!.wish10,
      AppLocalizations.of(context)!.wish11,
      AppLocalizations.of(context)!.wish12,
      AppLocalizations.of(context)!.wish13,
      AppLocalizations.of(context)!.wish14,
      AppLocalizations.of(context)!.wish15,
      AppLocalizations.of(context)!.wish16,
      AppLocalizations.of(context)!.wish17,
      AppLocalizations.of(context)!.wish18,
      AppLocalizations.of(context)!.wish19,
      AppLocalizations.of(context)!.wish20,
    ];

    int number = Random().nextInt(wishes.length);
    String wish = wishes[number];

    String name = widget.birthday.name;
    wish = wish.replaceAll('/name/', name);

    int age = Calculator.calculateAge(widget.birthday.date) + 1;
    wish = wish.replaceAll('/age/', age.toString());

    return wish;
  }
}
