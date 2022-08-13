import 'package:flutter/material.dart';

showSnackbar(context, String message,
    {bool removePwd = true, int duration = 3000}) {
  final snackBar = SnackBar(
    backgroundColor: Colors.grey[400],
    duration: Duration(milliseconds: duration),
    elevation: 4,
    content: Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.black,
      ),
    ),
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.black,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  if (removePwd) {
    // pwdTextController.text = "";
  }

  // Find the ScaffoldMessenger in the widget tree
  // and use it to show a SnackBar.
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
