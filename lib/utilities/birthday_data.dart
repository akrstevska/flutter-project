import 'package:flutter/material.dart';
import '../../utilities/Birthday.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Birthday> birthdayList = [];
String takenIdsKey = "takenIds";
Birthday? lastDeleted;

Future<void> initializeDataSystem() async {
  await loadBirthdays();
}

Future<void> loadBirthdays() async {
  try {
    final response = await http.get(Uri.parse(Constants.apiBaseUrl + '/Birthday?startIndex=1&endIndex=100000'));
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      birthdayList = data.map((json) => Birthday.fromJson(json)).toList();
    }
    else {
      throw Exception('Failed to load birthdays');
    }
  } catch (e) {
    print('Error fetching birthdays: $e');
  }
}

Birthday createBirthdayFromData(List<String> birthdayArray) {
  String name = birthdayArray[0];
  int year = int.parse(birthdayArray[1]);
  int month = int.parse(birthdayArray[2]);
  int day = int.parse(birthdayArray[3]);
  int hour = int.parse(birthdayArray[4]);
  int minute = int.parse(birthdayArray[5]);
  int birthdayId = int.parse(birthdayArray[6]);
  int notificationId = int.parse(birthdayArray[7]);
  int notificationDayId = int.parse(birthdayArray[8]);
  int notificationWeekId = int.parse(birthdayArray[9]);
  int notificationMonthId = int.parse(birthdayArray[10]);

  Birthday? birthday = Birthday(
    name,
    DateTime(year, month, day, hour, minute),
    birthdayId,
    [
      notificationId,
      notificationDayId,
      notificationWeekId,
      notificationMonthId,
    ],
  );

  return birthday;
}

Future<void> addBirthday(Birthday birthday) async {
  try {
    final url = Uri.parse('${Constants.apiBaseUrl}/Birthday');
    final headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };
    final body = jsonEncode(birthday.toJson());
    debugPrint('📝 Body: $body');
    final response = await http.post(url, headers: headers, body: body);
    debugPrint('Response Status: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');
    if (response.statusCode == 201) {
      birthdayList.add(birthday);
    } else {
      throw Exception('Failed to add birthday');
    }
  } catch (e) {
    debugPrint('Error adding birthday: $e');
  }
}

Future<void> removeBirthday(int birthdayId) async {
  try {
    final response = await http.delete(
      Uri.parse('${Constants.apiBaseUrl}/Birthday/$birthdayId'),
    );
    if (response.statusCode == 204) {
      // Birthday removed successfully
      birthdayList.removeWhere((birthday) => birthday.birthdayId == birthdayId);
    } else {
      throw Exception('Failed to remove birthday');
    }
  } catch (e) {
    print('Error removing birthday: $e');
    // Handle error as needed
  }
}

Future<void> updateBirthday(int birthdayId, Birthday updatedBirthday) async {
  try {
    final response = await http.put(
      Uri.parse('${Constants.apiBaseUrl}/Birthday/$birthdayId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(updatedBirthday.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      int index = birthdayList.indexWhere((birthday) => birthday.birthdayId == birthdayId);
      if (index != -1) {
        birthdayList[index] = updatedBirthday;
      }
    } else {
      throw Exception('Failed to update birthday: ${response.statusCode}');
    }

  } catch (e) {
    print('Error updating birthday: $e');
  }
}

bool restoreBirthday() {
  if (birthdayList.contains(lastDeleted)) {
    return false;
  }

  addBirthday(lastDeleted!);
  return true;
}

Birthday getDataById(int birthdayId) {
  for (int i = 0; i < birthdayList.length; i++) {
    if (birthdayList[i].birthdayId == birthdayId) {
      return birthdayList[i];
    }
  }

  return birthdayList.first;
}

int getNewBirthdayId() {
  if (birthdayList.isEmpty) {
    return 1;
  }

  int highestId = birthdayList[0].birthdayId;
  for (int i = 0; i < birthdayList.length; i++) {
    if (birthdayList[i].birthdayId > highestId) {
      highestId = birthdayList[i].birthdayId;
    }
  }

  return highestId + 1;
}
