import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/common/my_strings.dart';
import 'package:flutter_paystack/src/models/card.dart';
import 'package:flutter_paystack/src/widgets/input/base_field.dart';

class CVCField extends BaseTextField {
  bool isDarkMode;
  Color? darkModeTextColor;

  CVCField({
    Key? key,
    required PaymentCard? card,
    required FormFieldSetter<String> onSaved,
    this.isDarkMode = false,
    this.darkModeTextColor,
  }) : super(
          key: key,
          labelText: 'CVV',
          hintText: '123',
          onSaved: onSaved,
          validator: (String? value) => validateCVC(value, card),
          initialValue: card != null && card.cvc != null ? card.cvc.toString() : null,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
        );

  static String? validateCVC(String? value, PaymentCard? card) {
    if (value == null || value.trim().isEmpty) return Strings.invalidCVC;
    return card!.validCVC(value) ? null : Strings.invalidCVC;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      initialValue: initialValue,
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
      ),
      style: TextStyle(color: isDarkMode ? darkModeTextColor : theme.colorScheme.onSurface),
      validator: validator,
      inputFormatters: inputFormatters,
      onSaved: onSaved,
    );
  }
}
