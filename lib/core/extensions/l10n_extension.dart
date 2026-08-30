import 'package:flutter/material.dart';
import 'package:deposit_calc_satelit/gen/l10n.dart';

extension LocalizationExtension on BuildContext {
  S get l10n => S.of(this);
}
