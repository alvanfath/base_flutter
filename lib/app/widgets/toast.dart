import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastBottom(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 2,
    backgroundColor: const Color(0xff333333),
    textColor: Colors.white,
    fontSize: 12.0,
  );
}
