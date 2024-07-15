import 'package:flutter/widgets.dart';
import 'package:nvnotes/utility/dialogs/generic_dialog.dart';

Future<void> showErrorDialogue(
  BuildContext context,
  String text,
) {
  return showGenericDialog(
    context: context,
    title: 'An error occured',
    content: text,
    optionBuilder: () => {
      'OK': null,
    },
  );
}
