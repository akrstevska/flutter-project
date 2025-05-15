import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utilities/constants.dart';

class BirthdayGroupDropdown extends StatefulWidget {
  final Function(int) onValueChanged;
  final int? initialValue;

  const BirthdayGroupDropdown({
    Key? key,
    required this.onValueChanged,
    this.initialValue,
  }) : super(key: key);

  @override
  _BirthdayGroupDropdownState createState() => _BirthdayGroupDropdownState();
}

class _BirthdayGroupDropdownState extends State<BirthdayGroupDropdown> {
  List<Map<String, dynamic>> _birthdayGroups = [];
  int? _selectedGroupId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchBirthdayGroups();
  }

  Future<void> _fetchBirthdayGroups() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse('${Constants.apiBaseUrl}/BirthdayGroup'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _birthdayGroups = data.cast<Map<String, dynamic>>();

          // Set the selected group ID based on the initial value or default to the first group
          if (widget.initialValue != null) {
            _selectedGroupId = widget.initialValue;
          } else {
            _selectedGroupId = _birthdayGroups.isNotEmpty ? _birthdayGroups[0]['id'] : null;
          }

          // Notify parent about the initially selected value
          if (_selectedGroupId != null) {
            widget.onValueChanged(_selectedGroupId!);
          }

          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load birthday groups');
      }
    } catch (e) {
      debugPrint('Error fetching birthday groups: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Constants.purpleSecondary,
        ),
      );
    }

    if (_birthdayGroups.isEmpty) {
      return const Center(
        child: Text(
          'No birthday groups available',
          style: TextStyle(color: Constants.whiteSecondary),
        ),
      );
    }

    return DropdownButton<int>(
      value: _selectedGroupId,
      isExpanded: true,
      dropdownColor: Constants.greySecondary,
      style: const TextStyle(color: Constants.whiteSecondary),
      underline: Container(
        height: 2,
        color: Constants.purpleSecondary,
      ),
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _selectedGroupId = value;
          });
          widget.onValueChanged(value);
        }
      },
      items: _birthdayGroups.map<DropdownMenuItem<int>>((group) {
        return DropdownMenuItem<int>(
          value: group['id'],
          child: Text(
            group['name'],
            style: const TextStyle(
              fontSize: Constants.normalFontSize,
            ),
          ),
        );
      }).toList(),
    );
  }
}