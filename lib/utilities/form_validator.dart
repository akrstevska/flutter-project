import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class FormValidator {
  static String? validateRequired(BuildContext context, String? value, String fieldName) {
    final localizations = AppLocalizations.of(context)!;
    if (value == null || value.isEmpty) {
      return localizations.nameError;
    }
    return null;
  }

  static String? validateRequiredDate(BuildContext context, DateTime? value, String fieldName) {
    final localizations = AppLocalizations.of(context)!;
    if (value == null || value.toString().isEmpty) {
      return localizations.dateError;
    }
    return null;
  }
}
