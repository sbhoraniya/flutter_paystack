import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/common/card_utils.dart';
import 'package:flutter_paystack/src/common/my_strings.dart';
import 'package:flutter_paystack/src/models/card.dart';
import 'package:flutter_paystack/src/widgets/common/input_formatters.dart';
import 'package:flutter_paystack/src/widgets/input/base_field.dart';

class NumberField extends BaseTextField {
  PaymentCard? card;
  bool isDarkMode;
  Color? darkModeTextColor;

  NumberField({
    Key? key,
    required this.card,
    required TextEditingController? controller,
    required FormFieldSetter<String> onSaved,
    required Widget suffix,
    this.isDarkMode = false,
    this.darkModeTextColor,
  }) : super(
          key: key,
          labelText: 'CARD NUMBER',
          hintText: '0000 0000 0000 0000',
          controller: controller,
          onSaved: onSaved,
          suffix: suffix,
          validator: (String? value) => validateCardNum(value, card),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(19),
            CardNumberInputFormatter(),
          ],
        );

  static String? validateCardNum(String? input, PaymentCard? card) {
    if (input == null || input.isEmpty) {
      return Strings.invalidNumber;
    }

    input = CardUtils.getCleanedNumber(input);

    return card!.validNumber(input) ? null : Strings.invalidNumber;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(color: theme.hintColor),
        labelStyle: TextStyle(color: theme.colorScheme.onSurface),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colorScheme.secondary),
        ),
        suffixIcon: suffix,
      ),
      style: TextStyle(color: isDarkMode? darkModeTextColor:theme.colorScheme.onSurface),
      validator: (value) => validateCardNum(value, card),
      inputFormatters: inputFormatters,
      onSaved: onSaved,
    );
  }
}
