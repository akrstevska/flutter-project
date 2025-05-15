import '../utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:yaml/yaml.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final ScrollController _scrollController = ScrollController();

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
        AppLocalizations.of(context)!.about,
        style: const TextStyle(
          color: Constants.purpleSecondary,
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
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

  Widget body() {
    return RawScrollbar(
      thumbColor: Constants.lighterGrey,
      radius: const Radius.circular(20),
      thickness: 5,
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: FutureBuilder(
          future: rootBundle.loadString('pubspec.yaml'),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              String version = loadYaml(snapshot.data as String)['version'];
              return pageWidgets(context, version);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Row pageWidgets(BuildContext context, String version) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            appIcon(),
            const SizedBox(height: 20),
            appInfo(context),
            appAuthor(),
            const SizedBox(height: 30),
            appVersion(context, version),
          ],
        ),
      ],
    );
  }

  Text appVersion(BuildContext context, String version) {
    return Text(
      '${AppLocalizations.of(context)!.version}: $version',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: Constants.normalFontSize,
        color: Constants.lighterGrey,
      ),
    );
  }

  Text appAuthor() {
    return Text(
      '~ ${AppLocalizations.of(context)!.appAuthor}',
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: Constants.normalFontSize,
        color: Constants.lighterGrey,
      ),
    );
  }

  SizedBox appInfo(BuildContext context) {
    return SizedBox(
      width: 240,
      child: Text(
        AppLocalizations.of(context)!.aboutInfo,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: Constants.normalFontSize,
          color: Constants.lighterGrey,
        ),
      ),
    );
  }

  SizedBox appIcon() {
    return SizedBox(
      width: 100,
      child: Image.asset('assets/images/app_icon_android.png'),
    );
  }
}
