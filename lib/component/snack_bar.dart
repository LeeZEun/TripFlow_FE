import 'package:flutter/material.dart';

import '../constants.dart';

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: snackBarTextColor),
      ),
      backgroundColor: snackBarBackgroundColor,
    ),
  );
}
