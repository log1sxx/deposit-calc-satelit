import 'package:deposit_calc_satelit/features/deposit_calculator/data/utils/text_editing_extension.dart';
import 'package:deposit_calc_satelit/features/deposit_calculator/presentation/styles/my_finances_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNumericField extends StatefulWidget {
  final TextEditingController controller;
  final double initial;
  final double min;
  final double max;
  final TextAlign textAlign;
  final int fractionDigits;
  final void Function(double value)? onUpdate;

  const AppNumericField({
    super.key,
    required this.controller,
    required this.initial,
    required this.min,
    required this.max,
    this.textAlign = TextAlign.left,
    this.fractionDigits = 0,
    this.onUpdate,
  });

  @override
  State<AppNumericField> createState() => _AppNumericFieldState();
}

class _AppNumericFieldState extends State<AppNumericField> {
  @override
  void initState() {
    super.initState();
    widget.controller.setNumericValue(
      widget.initial,
      fractionDigits: widget.fractionDigits,
    );
  }

  void _updateValue(double value) {
    widget.controller.setNumericValue(
      value,
      fractionDigits: widget.fractionDigits,
    );
    if (widget.onUpdate != null) {
      widget.onUpdate!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );
    return SizedBox(
      height: 48,
      child: Focus(
        onFocusChange: (hasFocus) {
          if (hasFocus) return;
          if (widget.controller.text.isEmpty) {
            _updateValue(widget.min);
            return;
          }
          var value = widget.controller.numericValue;
          if (value < widget.min) {
            value = widget.min;
          } else if (value > widget.max) {
            value = widget.max;
          }
          _updateValue(value);
        },
        child: TextFormField(
          controller: widget.controller,
          textAlign: widget.textAlign,
          /*        onChanged: (value) {
            widget.controller.text = value;
            print(widget.controller.text);
          }, */
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            contentPadding: EdgeInsets.only(
              right: widget.textAlign != TextAlign.right ? 0 : 16,
              left: widget.textAlign == TextAlign.right ? 0 : 16,
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^[\d|\s]*,?\d{0,2}')),
          ],
          keyboardType: const TextInputType.numberWithOptions(),
          style: AppStyles.body.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
