import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'birthday_group.dart';

List<BirthdayGroup> groupList = [];


Future<void> loadBirthdayGroups() async {
  try {
    final response = await http.get(Uri.parse('${Constants.apiBaseUrl}/BirthdayGroup'));
    debugPrint('Group response code: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      groupList = data.map((json) => BirthdayGroup.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load groups');
    }
  } catch (e) {
    debugPrint('Error loading groups: $e');
  }
}


Future<void> updateBirthdayGroup(BirthdayGroup group) async {
  try {
    final response = await http.put(
      Uri.parse('${Constants.apiBaseUrl}/BirthdayGroup/${group.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(group.toJson()),
    );
    if (response.statusCode == 200) {
      int index = groupList.indexWhere((g) => g.id == group.id);
      if (index != -1) groupList[index] = group;
    } else {
      throw Exception('Failed to update group');
    }
  } catch (e) {
    debugPrint('Error updating group: $e');
  }
}

Future<String?> deleteBirthdayGroup(int id) async {
  try {
    final response = await http.delete(Uri.parse('${Constants.apiBaseUrl}/BirthdayGroup/$id'));
    if (response.statusCode == 204) {
      groupList.removeWhere((g) => g.id == id);
      return null;
    } else if (response.statusCode == 400) {
      return response.body;
    } else {
      throw Exception('Failed to delete group');
    }
  } catch (e) {
    debugPrint('Error deleting group: $e');
    return 'An unexpected error occurred.';
  }
}

