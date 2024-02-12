import 'package:flutter/material.dart';
import 'package:flutter_cubit/app/constants/app_constants.dart';

InputDecoration inputDecor(
  BuildContext context,
  Color activeColor,
  String hintText,
  bool error,
) {
  return InputDecoration(
    errorText: error ? '' : null,
    hintText: hintText,
    hintStyle: const TextStyle(
      color: Color(0xffBEBEBE),
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xffDDDDDD),
        width: 1.0,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppConstants.errorColor,
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: activeColor,
        width: 1.0,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(
        color: AppConstants.errorColor,
      ),
    ),
  );
}
