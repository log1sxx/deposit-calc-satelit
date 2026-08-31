import 'package:deposit_calc_satelit/features/deposit_calculator/data/utils/formatters.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const formatter = ThousandsSeparatorInputFormatter();

  test('groups money digits while typing', () {
    final value = formatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(
        text: '100000',
        selection: TextSelection.collapsed(offset: 6),
      ),
    );

    expect(value.text, '100 000');
    expect(value.selection.baseOffset, 7);
  });

  test('keeps cursor position when editing in the middle', () {
    final value = formatter.formatEditUpdate(
      const TextEditingValue(text: '100 000'),
      const TextEditingValue(
        text: '1200 000',
        selection: TextSelection.collapsed(offset: 2),
      ),
    );

    expect(value.text, '1 200 000');
    expect(value.selection.baseOffset, 3);
  });

  test('formats date digits while typing', () {
    const dateFormatter = DateInputFormatter();
    final value = dateFormatter.formatEditUpdate(
      TextEditingValue.empty,
      const TextEditingValue(
        text: '12122026',
        selection: TextSelection.collapsed(offset: 8),
      ),
    );

    expect(value.text, '12.12.2026');
    expect(value.selection.baseOffset, 10);
  });

  test('rejects impossible and out of range dates', () {
    final firstDate = DateTime(2026);
    final lastDate = DateTime(2100, 12, 31);

    expect(
      validateDateInput('31.02.2026', firstDate: firstDate, lastDate: lastDate),
      'Укажите корректную дату',
    );
    expect(
      validateDateInput('31.12.2025', firstDate: firstDate, lastDate: lastDate),
      isNotNull,
    );
    expect(
      validateDateInput('12.12.2026', firstDate: firstDate, lastDate: lastDate),
      isNull,
    );
  });
}
