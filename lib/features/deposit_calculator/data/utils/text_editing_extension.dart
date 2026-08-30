import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TextEditingExtension on TextEditingController {
  static final formatter = NumberFormat.decimalPattern('ru');

  double get numericValue => formatter.parse(text) as double;

  void setNumericValue(double value, {required int fractionDigits}) {
    formatter.minimumFractionDigits = fractionDigits;
    formatter.maximumFractionDigits = fractionDigits;
    text = formatter.format(value);
  }

  int getOriginalDigit(String formattedString) {
    return formatter
        .parse(formattedString.isEmpty ? '0' : formattedString)
        .toInt();
  }
}
