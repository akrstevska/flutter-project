import '../../components/birthday_card/birthday_card.dart';
import '../../components/date_picker.dart';
import '../../components/time_picker.dart';
import '../../components/view_title.dart';
import '../../utilities/Birthday.dart';
import '../../utilities/birthday_data.dart';
import '../../utilities/constants.dart';
import '../../utilities/birthday_group_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utilities/form_validator.dart';

class BirthdayEditPage extends StatefulWidget {
  final int birthdayId;

  const BirthdayEditPage(this.birthdayId, {Key? key}) : super(key: key);

  @override
  State<BirthdayEditPage> createState() => _BirthdayEditPageState();
}

class _BirthdayEditPageState extends State<BirthdayEditPage> {
  late String newName;
  late DateTime newDate;
  late TimeOfDay newTime;
  late int? selectedGroupId; 
  late String newNotes;

  final ScrollController _scrollController = ScrollController();

  final _formKey = GlobalKey<FormState>();
  bool isNameInputCorrect = true;

  @override
  void initState() {
    Birthday birthday = getDataById(widget.birthdayId);
    newName = birthday.name;
    newDate = birthday.date;
    newTime = TimeOfDay(hour: newDate.hour, minute: newDate.minute);
    selectedGroupId = birthday.birthdayGroupId;
    newNotes = birthday.note ?? '';
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

  RawScrollbar body(BuildContext context) {
    return RawScrollbar(
      thumbColor: Constants.lighterGrey,
      radius: const Radius.circular(20),
      thickness: 5,
      thumbVisibility: true,
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ViewTitle('${AppLocalizations.of(context)!.editName}:'),
              inputNameField(),
              const SizedBox(height: 40),
              ViewTitle('${AppLocalizations.of(context)!.editDate}:'),
              datePicker(),
              const SizedBox(height: 40),
              ViewTitle('${AppLocalizations.of(context)!.editTime}:'),
              timePicker(),
              infoText(AppLocalizations.of(context)!.timeInfo),
              const SizedBox(height: 40),
              ViewTitle('Birthday Group:'),
              groupDropdown(),
              const SizedBox(height: 40),
              ViewTitle('Notes:'),
              inputNotesField(),
              const SizedBox(height: 40),
              ViewTitle('${AppLocalizations.of(context)!.preview}:'),
              cardPreview(),
              const SizedBox(height: 40),
              saveButton(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget groupDropdown() {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.greySecondary,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: BirthdayGroupDropdown(
        initialValue: selectedGroupId, 
        onValueChanged: (int? groupId) { 
          setState(() {
            selectedGroupId = groupId;
          });
        },
      ),
    );
  }

  Widget datePicker() {
    String? dateErrorMessage;
    return Column(
      children: [
        DatePicker(
          newDate,
          onDayChanged: (newDayTime) {
            setState(() {
              newDate = newDayTime;
              dateErrorMessage = FormValidator.validateRequiredDate(
                  context,
                  newDayTime,
                  AppLocalizations.of(context)!.editDate
              );
            });
          },
        ),
        if (dateErrorMessage != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            width: double.infinity,
            child: Text(
              dateErrorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: Constants.smallerFontSize,
              ),
            ),
          ),
      ],
    );
  }

  TimePicker timePicker() {
    return TimePicker(
      newTime,
      onTimeChanged: (newDateTime) {
        setState(() {
          newTime = newDateTime;
        });
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Constants.blackPrimary,
      iconTheme: IconThemeData(
        color: Constants.whiteSecondary,
      ),
      title: Text(
        AppLocalizations.of(context)!.birthdayEdit,
        style: const TextStyle(
          color: Constants.purpleSecondary,
          fontSize: Constants.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: cancelButton(context),
    );
  }

  GestureDetector cancelButton(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
        margin: const EdgeInsets.only(left: 15),
        child: const Icon(
          Icons.close,
          size: 25,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
      },
    );
  }

  Container inputNameField() {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.greySecondary,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: TextFormField(
          initialValue: getDataById(widget.birthdayId).name,
          keyboardType: TextInputType.text,
          keyboardAppearance: Brightness.dark,
          style: const TextStyle(color: Constants.whiteSecondary),
          inputFormatters: [
            LengthLimitingTextInputFormatter(12),
          ],
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 3, color: Constants.purpleSecondary),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            fillColor: Constants.purpleSecondary,
            focusColor: Constants.purpleSecondary,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              borderSide: BorderSide.none,
            ),
            floatingLabelStyle: const TextStyle(
              color: Constants.purpleSecondary,
              fontSize: Constants.biggerFontSize,
              fontWeight: FontWeight.bold,
            ),
            hintStyle: const TextStyle(
              color: Constants.lighterGrey,
              fontSize: 15,
            ),
            labelText: AppLocalizations.of(context)!.name,
            labelStyle: const TextStyle(
              color: Constants.whiteSecondary,
              fontSize: Constants.normalFontSize,
            ),
            errorStyle: const TextStyle(
              fontSize: Constants.smallerFontSize,
              color: Colors.red,
            ),
          ),
          onChanged: (String? value) {
            setState(() {
              newName = value.toString();
            });
          },
          validator: (String? value) {
            String? validationResult = FormValidator.validateRequired(
                context,
                value,
                AppLocalizations.of(context)!.name
            );

            if (validationResult != null) {
              setState(() {
                isNameInputCorrect = false;
              });
            } else {
              setState(() {
                isNameInputCorrect = true;
              });
            }

            return validationResult;
          },
        ),
      ),
    );
  }

  Container inputNotesField() {
    return Container(
      decoration: const BoxDecoration(
        color: Constants.greySecondary,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        initialValue: newNotes,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        keyboardAppearance: Brightness.dark,
        style: const TextStyle(color: Constants.whiteSecondary),
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 3, color: Constants.purpleSecondary),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          fillColor: Constants.purpleSecondary,
          focusColor: Constants.purpleSecondary,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide.none,
          ),
          floatingLabelStyle: const TextStyle(
            color: Constants.purpleSecondary,
            fontSize: Constants.biggerFontSize,
            fontWeight: FontWeight.bold,
          ),
          hintStyle: const TextStyle(
            color: Constants.lighterGrey,
            fontSize: 15,
          ),
          labelText: 'Notes',
          labelStyle: const TextStyle(
            color: Constants.whiteSecondary,
            fontSize: Constants.normalFontSize,
          ),
        ),
        onChanged: (String? value) {
          setState(() {
            newNotes = value.toString();
          });
        },
      ),
    );
  }

  Container cardPreview() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: BirthdayCard(Birthday(newName, newDate), false),
    );
  }

  Container saveButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
          isNameInputCorrect ? Constants.purpleSecondary : Colors.red,
        ),
        child: Text(
          AppLocalizations.of(context)!.save,
          style: const TextStyle(
              color: Constants.whiteSecondary,
              fontSize: Constants.normalFontSize,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          saveBirthday(context);
        },
      ),
    );
  }

  void saveBirthday(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        isNameInputCorrect = false;
      });
      return;
    }

    Birthday updatedBirthday = Birthday(
      newName,
      DateTime(newDate.year, newDate.month, newDate.day, newTime.hour,
          newTime.minute),
      widget.birthdayId,
      null,
      null,
      selectedGroupId, 
      newNotes,
    );

    try {
      await updateBirthday(widget.birthdayId, updatedBirthday);
      Navigator.pop(context);
    } catch (e) {
      print('Error saving birthday: $e');
    }
  }

  Row infoText(String text) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 30, right: 30),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Constants.darkerGrey,
                  fontSize: Constants.normalFontSize,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
