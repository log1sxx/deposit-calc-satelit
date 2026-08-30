import 'package:intl/intl.dart';

final formatter0 = NumberFormat.decimalPattern('ru')..maximumFractionDigits = 0;

final dateFormatterDMY = DateFormat('dd.MM.yyyy');

final dateFormatterMY = DateFormat('MM.yyyy');

String currency(double value) => '${formatter0.format(value)} ₽';

String dateDMY(DateTime dateTime) => dateFormatterDMY.format(dateTime);

String dateMY(DateTime dateTime) => dateFormatterMY.format(dateTime);
