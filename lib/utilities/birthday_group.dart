import 'birthday.dart';

class BirthdayGroup {
  int id;
  String name;
  String? email;
  List<Birthday> birthdays;
  List<GroupSetting> settings;

  BirthdayGroup({
    required this.id,
    required this.name,
    required this.email,
    required this.birthdays,
    required this.settings,
  });

  factory BirthdayGroup.fromJson(Map<String, dynamic> json) {
    return BirthdayGroup(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      birthdays: (json['birthdays'] ?? [])
          .map<Birthday>((b) => Birthday.fromJson(b))
          .toList(),
      settings: (json['settings'] ?? [])
          .map<GroupSetting>((s) => GroupSetting.fromJson(s))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'birthdays': birthdays.map((b) => b.toJson()).toList(),
      'settings': settings.map((s) => s.toJson()).toList(),
    };
  }
}

class GroupSetting {
  int id;
  String dateTimeFormat;
  bool notificationsEnabled;
  int birthdayGroupId;
  String birthdayGroup;

  GroupSetting({
    required this.id,
    required this.dateTimeFormat,
    required this.notificationsEnabled,
    required this.birthdayGroupId,
    required this.birthdayGroup,
  });

  factory GroupSetting.fromJson(Map<String, dynamic> json) {
    return GroupSetting(
      id: json['id'],
      dateTimeFormat: json['dateTimeFormat'],
      notificationsEnabled: json['notificationsEnabled'],
      birthdayGroupId: json['birthdayGroupId'],
      birthdayGroup: json['birthdayGroup'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateTimeFormat': dateTimeFormat,
      'notificationsEnabled': notificationsEnabled,
      'birthdayGroupId': birthdayGroupId,
      'birthdayGroup': birthdayGroup,
    };
  }
}
