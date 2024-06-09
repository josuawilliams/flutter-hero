import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

void showAlertError(BuildContext context, String text) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.error,
    title: "Oops..",
    text: text,
  );
}

void showAlert(BuildContext context, String text, Function()? onConfirm) {
  QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: text,
      onConfirmBtnTap: () {
        if (onConfirm != null) {
          onConfirm();
        }
      });
}
