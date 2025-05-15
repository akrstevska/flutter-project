import '../components/view_title.dart';
import 'about_page.dart';
import '../utilities/constants.dart';
import '../../utilities/notification_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.blackPrimary,
      appBar: appBar(),
      body: body(),
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
        AppLocalizations.of(context)!.settings,
        style: const TextStyle(
          color: Constants.purpleSecondary,
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        infoButton(context),
      ],
      leading: backButton(context),
    );
  }

  GestureDetector backButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  GestureDetector infoButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: const Icon(
          Icons.info_outline,
          size: 30,
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return const AboutPage();
          },
        ));
      },
    );
  }

  Widget body() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          ViewTitle(AppLocalizations.of(context)!.exportImport),
          //TODO Group3: Export/Import JSON file
        ],
      ),
    );
  }
}
