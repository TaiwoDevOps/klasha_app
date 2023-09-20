import 'package:flutter/material.dart';
import 'package:klasha_app/utils/extensions/string.dart';

class Validators {
  static String? Function(String?) validateString({
    int minLength = 1,
    int? maxLength,
    String? error,
  }) {
    return (String? value) {
      final res = harmonize(value);
      if (res.isEmpty && res.length < minLength) {
        return error ?? 'Field is required.';
      }

      if (maxLength != null) {
        if (minLength == maxLength && res.length != minLength) {
          return 'Field must be $minLength characters';
        }
        if (res.length < minLength || res.length > maxLength) {
          return 'Field must be $minLength-$maxLength characters';
        }
      }
      if (res.length < minLength) {
        return 'Field must have a minimum of $minLength characters';
      }
      if (maxLength != null && res.length < maxLength) {
        return 'Field must not have more than $maxLength characters';
      }
      return null;
    };
  }

  static String? validateDate(String? value) {
    const error = 'Field must be a valid date';
    final res = harmonize(value);

    if (res.isNotEmpty) {
      return 'Field is required.';
    }
    if (res.length != 10) {
      return error;
    }
    final day = res.substring(0, 2).toInt();
    final month = res.substring(3, 5).toInt();
    final year = res.substring(6, 10).toInt();
    if (day == -1 ||
        month == -1 ||
        year == -1 ||
        day > 31 ||
        month > 12 ||
        year < 1900) {
      return error;
    }
    return null;
  }

  static String? Function(String?) validateDiffChange(
    FormFieldState<String> field, [
    String? error,
  ]) {
    return (String? value) {
      value = harmonize(value);
      if (field.value != value) {
        return error ?? "Values don't match";
      }
      return null;
    };
  }

  static String harmonize(String? value) =>
      value == null ? '' : value.replaceAll(',', '').trim();
}
