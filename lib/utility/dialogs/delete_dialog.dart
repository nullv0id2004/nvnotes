import 'package:flutter/material.dart';
import 'package:nvnotes/utility/dialogs/generic_dialog.dart';

Future<bool> showDeleteDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Delete note',
    content: 'Are u sure u want to delete this note?',
    optionBuilder: () => {
      'Cancel': false,
      'Delete': true,
    },
  ).then(
    (value) => value ?? false,
  );
}