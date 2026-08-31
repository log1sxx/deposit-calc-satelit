import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final formatter0 = NumberFormat.decimalPattern('ru')..maximumFractionDigits = 0;

final dateFormatterDMY = DateFormat('dd.MM.yyyy');

final dateFormatterMY = DateFormat('MM.yyyy');

String currency(double value) => '${formatter0.format(value)} ₽';

String dateDMY(DateTime dateTime) => dateFormatterDMY.format(dateTime);

String dateMY(DateTime dateTime) => dateFormatterMY.format(dateTime);

String? validateDateInput(
  String? value, {
  required DateTime firstDate,
  required DateTime lastDate,
}) {
  if (value == null || value.isEmpty) return 'Введите дату';
  if (value.length != 10) return 'Введите дату в формате ДД.ММ.ГГГГ';
  try {
    final date = dateFormatterDMY.parseStrict(value);
    if (date.isBefore(firstDate)) {
      return 'Дата не может быть раньше ${dateDMY(firstDate)}';
    }
    if (date.isAfter(lastDate)) {
      return 'Дата не может быть позже ${dateDMY(lastDate)}';
    }
  } on FormatException {
    return 'Укажите корректную дату';
  }
  return null;
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  const ThousandsSeparatorInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return const TextEditingValue();
    digits = digits.replaceFirst(RegExp(r'^0+(?=\d)'), '');

    final digitsBeforeCursor = newValue.text
        .substring(0, newValue.selection.end.clamp(0, newValue.text.length))
        .replaceAll(RegExp(r'[^0-9]'), '')
        .length;
    final formatted = _groupDigits(digits);
    var cursor = 0;
    var seenDigits = 0;
    while (cursor < formatted.length && seenDigits < digitsBeforeCursor) {
      if (_isDigit(formatted.codeUnitAt(cursor))) seenDigits++;
      cursor++;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursor),
    );
  }

  String _groupDigits(String digits) {
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(' ');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }

  bool _isDigit(int codeUnit) => codeUnit >= 48 && codeUnit <= 57;
}

class DateInputFormatter extends TextInputFormatter {
  const DateInputFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final allDigits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final digits = allDigits.length > 8 ? allDigits.substring(0, 8) : allDigits;
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i == 2 || i == 4) buffer.write('.');
      buffer.write(digits[i]);
    }
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
