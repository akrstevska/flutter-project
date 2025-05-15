import '../components/birthday_card/birthday_card_listview.dart';
import '../components/manage_groups_dialog.dart';
import 'birthday_add_page.dart';
import 'settings_page.dart';
import '../utilities/app_data.dart';
import '../utilities/birthday_data.dart';
import '../utilities/constants.dart';
import '../../utilities/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackPrimary,
      appBar: appBar(),
      body: body(context),
    );
  }

  Center body(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 30),
        child: Column(
          children: [
            birthdayList.isNotEmpty
                ? const BirthdayCardListview()
                : emptyPageText(),
            addBirthdayButton(context),
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Constants.blackPrimary,
      iconTheme: IconThemeData(
        color: Constants.whiteSecondary,
      ),
      title: Text(
        AppLocalizations.of(context)!.birthdays,
        style: const TextStyle(
          color: Constants.purpleSecondary,
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.group),
          tooltip: 'Manage Groups',
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => ManageGroupsDialog(),
            ).then((_) => setState(() {}));
          },
        ),
        settingsButton(context),

      ],
    );
  }

  GestureDetector settingsButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: const Icon(
          Icons.settings,
          size: 30,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return const SettingsPage();
          },
        ));
      },
    );
  }

  Widget emptyPageText() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.addBirthday,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: Constants.normalFontSize,
              color: Constants.greyPrimary,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10.0),
            child: const Icon(
              Icons.keyboard_double_arrow_down_rounded,
              color: Constants.lighterGrey,
            ),
          )
        ],
      ),
    );
  }

  Container addBirthdayButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0, bottom: 23.0),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Constants.whiteSecondary,
          backgroundColor: Constants.darkGreySecondary,
          fixedSize: const Size(90, 70),
          side: const BorderSide(color: Constants.greySecondary, width: 3),
          shape: const StadiumBorder(),
        ),
        child: const Icon(
          Icons.add_rounded,
          color: Constants.whiteSecondary,
          size: 35,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return const AddBirthdayPage();
          })).then(
            (value) => setState(
              () {},
            ),
          );
        },
      ),
    );
  }
}
