// import 'dart:io';
//
// import 'package:awesome_notifications/awesome_notifications.dart';
// import '../../screens/birthday_info_page.dart';
// import '../../utilities/Birthday.dart';
// import '../../utilities/birthday_data.dart';
// import '../../utilities/calculator.dart';
// import '../../utilities/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../main.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// bool addedNotificationListener = false;
//
// bool notiOneDayBefore = false;
// bool notiOneWeekBefore = false;
// bool notiOneMonthBefore = false;
//
// void initializeNotificationSystem() async {
//   await AwesomeNotifications().initialize(
//     null,
//     [
//       NotificationChannel(
//         channelGroupKey: 'scheduled_channel_group',
//         channelKey: 'scheduled_channel',
//         channelName: 'Scheduled Notifications',
//         channelDescription: 'Notification channel for basic notifications',
//         defaultColor: Constants.purpleSecondary,
//         importance: NotificationImportance.High,
//         channelShowBadge: true,
//       )
//     ],
//     channelGroups: [
//       NotificationChannelGroup(
//         channelGroupName: 'Basic group',
//         channelGroupKey: 'basic_channel_group',
//       )
//     ],
//   );
//
//   final prefs = await SharedPreferences.getInstance();
//
//   bool? settingOneDay = prefs.getBool('getNotificationOneDayBefore');
//   if (settingOneDay == null) {
//     await prefs.setBool('getNotificationOneDayBefore', false);
//   } else {
//     notiOneDayBefore = settingOneDay;
//   }
//
//   bool? settingOneWeek = prefs.getBool('notificationOneWeekBefore');
//   if (settingOneWeek == null) {
//     await prefs.setBool('notificationOneWeekBefore', false);
//   } else {
//     notiOneWeekBefore = settingOneWeek;
//   }
//
//   bool? settingOneMonth = prefs.getBool('getNotificationOneMonthBefore');
//   if (settingOneMonth == null) {
//     await prefs.setBool('getNotificationOneMonthBefore', false);
//   } else {
//     notiOneMonthBefore = settingOneMonth;
//   }
// }
//
// void requestNotificationAccess(BuildContext context) async {
//   await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
//     if (!isAllowed) {
//       if (Platform.isIOS) {
//         AwesomeNotifications()
//             .requestPermissionToSendNotifications()
//             .then((value) => value ? addNotificationListener() : null);
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: Text(AppLocalizations.of(context)!.allowNotifications),
//             content: Text(
//               AppLocalizations.of(context)!.allowNotificationsHint,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text(
//                   'Don\'t Allow',
//                   style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   AwesomeNotifications()
//                       .requestPermissionToSendNotifications()
//                       .then(
//                     (value) {
//                       value ? addNotificationListener() : null;
//                       Navigator.pop(context);
//                     },
//                   );
//                 },
//                 child: const Text(
//                   'Allow',
//                   style: TextStyle(
//                     color: Colors.teal,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       }
//     }
//   });
// }
//
// void addNotificationListener() {
//   if (addedNotificationListener) {
//     return;
//   }
//
//   AwesomeNotifications().setListeners(
//     onActionReceivedMethod: onNotificationClick,
//   );
//
//   addedNotificationListener = true;
// }
//
// @pragma('vm:entry-point')
// Future<void> onNotificationClick(ReceivedAction notification) async {
//   if (Platform.isIOS) {
//     AwesomeNotifications().getGlobalBadgeCounter().then((value) {
//       return AwesomeNotifications().setGlobalBadgeCounter(value - 1);
//     });
//   }
//
//   if (notification.channelKey != 'scheduled_channel') {
//     return;
//   }
//
//   String? value = notification.payload?.entries
//       .where((element) => element.key == "bid")
//       .first
//       .value;
//
//   if (value == null) {
//     return;
//   }
//
//   navigatorKey.currentState?.push(MaterialPageRoute(
//     builder: (context) => BirthdayInfoPage(int.parse(value)),
//   ));
// }
//
// Future<void> setNotificationOneDayBefore(value) async {
//   notiOneDayBefore = value;
//
//   for (int i = 0; i < birthdayList.length; i++) {
//     if (notiOneDayBefore) {
//       createNotificationOneDayBefore(birthdayList[i]);
//     } else {
//       AwesomeNotifications().cancel(birthdayList[i].notificationIds[1]);
//     }
//   }
//
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('notificationOneWeekBefore', value);
// }
//
// Future<void> setNotificationOneWeekBefore(value) async {
//   notiOneWeekBefore = value;
//
//   for (int i = 0; i < birthdayList.length; i++) {
//     if (notiOneWeekBefore) {
//       createNotificationOneWeekBefore(birthdayList[i]);
//     } else {
//       AwesomeNotifications().cancel(birthdayList[i].notificationIds[2]);
//     }
//   }
//
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('notificationOneWeekBefore', value);
// }
//
// Future<void> setNotificationOneMonthBefore(value) async {
//   notiOneMonthBefore = value;
//
//   for (int i = 0; i < birthdayList.length; i++) {
//     if (notiOneMonthBefore) {
//       createNotificationOneMonthBefore(birthdayList[i]);
//     } else {
//       AwesomeNotifications().cancel(birthdayList[i].notificationIds[3]);
//     }
//   }
//
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setBool('getNotificationOneMonthBefore', value);
// }
//
// Future<void> createAllNotifications(Birthday birthday) async {
//   createNotification(
//     birthday,
//     birthday.date,
//     birthday.notificationIds[0],
//     "${AppLocalizations.of(navigatorKey.currentContext!)!.notificationTitle} ${Emojis.smile_partying_face}",
//     "${birthday.name} ${AppLocalizations.of(navigatorKey.currentContext!)!.turned} ${Calculator.calculateAge(birthday.date)}!",
//   );
//
//   if (notiOneDayBefore) {
//     createNotificationOneDayBefore(birthday);
//   }
//
//   if (notiOneWeekBefore) {
//     createNotificationOneWeekBefore(birthday);
//   }
//
//   if (notiOneMonthBefore) {
//     createNotificationOneMonthBefore(birthday);
//   }
// }
//
// void createNotificationOneDayBefore(Birthday birthday) {
//   DateTime time = DateTime(
//     birthday.date.year,
//     birthday.date.month,
//     birthday.date.day - 1,
//     birthday.date.hour,
//     birthday.date.minute,
//   );
//
//   createNotification(
//     birthday,
//     time,
//     birthday.notificationIds[1],
//     "${AppLocalizations.of(navigatorKey.currentContext!)!.notificationTitle} ${Emojis.smile_partying_face}",
//     "${birthday.name} ${AppLocalizations.of(navigatorKey.currentContext!)!.tomorrow1} ${Calculator.calculateAge(birthday.date)} ${AppLocalizations.of(navigatorKey.currentContext!)!.tomorrow2}!",
//   );
// }
//
// void createNotificationOneWeekBefore(Birthday birthday) {
//   DateTime time = DateTime(
//     birthday.date.year,
//     birthday.date.month,
//     birthday.date.day - 7,
//     birthday.date.hour,
//     birthday.date.minute,
//   );
//
//   createNotification(
//     birthday,
//     time,
//     birthday.notificationIds[2],
//     "${AppLocalizations.of(navigatorKey.currentContext!)!.notificationTitle} ${Emojis.smile_partying_face}",
//     "${birthday.name} ${AppLocalizations.of(navigatorKey.currentContext!)!.week1} ${Calculator.calculateAge(birthday.date)} ${AppLocalizations.of(navigatorKey.currentContext!)!.week2}!",
//   );
// }
//
// void createNotificationOneMonthBefore(Birthday birthday) {
//   DateTime time = DateTime(
//     birthday.date.year,
//     birthday.date.month - 1,
//     birthday.date.day,
//     birthday.date.hour,
//     birthday.date.minute,
//   );
//
//   createNotification(
//     birthday,
//     time,
//     birthday.notificationIds[3],
//     "${AppLocalizations.of(navigatorKey.currentContext!)!.notificationTitle} ${Emojis.smile_partying_face}",
//     "${birthday.name} ${AppLocalizations.of(navigatorKey.currentContext!)!.month1} ${Calculator.calculateAge(birthday.date)} ${AppLocalizations.of(navigatorKey.currentContext!)!.month2}!",
//   );
// }
//
// void cancelAllNotifications(Birthday birthday) {
//   AwesomeNotifications().cancel(birthday.notificationIds[0]);
//   AwesomeNotifications().cancel(birthday.notificationIds[1]);
//   AwesomeNotifications().cancel(birthday.notificationIds[2]);
//   AwesomeNotifications().cancel(birthday.notificationIds[3]);
// }
//
// Future<void> createNotification(
//   Birthday birthday,
//   DateTime time,
//   int notificationId,
//   String headline,
//   String info,
// ) async {
//   await AwesomeNotifications().createNotification(
//     content: NotificationContent(
//       id: notificationId,
//       channelKey: 'scheduled_channel',
//       title: headline,
//       body: info,
//       notificationLayout: NotificationLayout.Default,
//       payload: {"bid": birthday.birthdayId.toString()},
//     ),
//     actionButtons: [
//       NotificationActionButton(
//         key: 'MARK_DONE',
//         label: 'Open Birthday',
//       ),
//     ],
//     schedule: NotificationCalendar(
//       month: time.month,
//       day: time.day,
//       hour: time.hour,
//       minute: time.minute,
//       second: 0,
//       millisecond: 0,
//       repeats: true,
//       allowWhileIdle: true,
//       preciseAlarm: true,
//     ),
//   );
// }
