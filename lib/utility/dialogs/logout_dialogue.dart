import 'package:flutter/material.dart';
import 'package:nvnotes/utility/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Logout',
    content: 'Do you want to Logout',
    optionBuilder: () => {
      'Cancel': false,
      'Logout': true,
    },
  ).then(
    (value) => value ?? false,
  );
}
