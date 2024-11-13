import 'package:agenda_pagamentos/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? hintText;
  final bool? enabled;
  final bool autocorrect;
  final bool enableSuggestions;
  final List<TextInputFormatter> inputFormatters;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool obscureText;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextCapitalization textCapitalization;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? labelText;
  final TextAlign? textAlign;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.initialValue,
    this.hintText,
    this.enabled,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.inputFormatters = const [],
    this.keyboardType,
    this.maxLines,
    this.obscureText = false,
    this.onEditingComplete,
    this.onTap,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.textCapitalization = TextCapitalization.sentences,
    this.prefixIcon,
    this.suffixIcon,
    this.labelText,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Text(
              labelText!,
              style: AppTypography.bodyText1.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        TextFormField(
          initialValue: initialValue,
          controller: controller,
          focusNode: focusNode,
          enabled: enabled,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textAlign: textAlign ?? TextAlign.start,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          maxLines: maxLines,
          obscureText: obscureText,
          onEditingComplete: onEditingComplete,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          readOnly: readOnly,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            hintText: hintText,
            hintMaxLines: 2,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          style: AppTypography.bodyText1.copyWith(fontSize: 15),
        ),
      ],
    );
  }
}
