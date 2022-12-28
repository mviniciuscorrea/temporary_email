import 'package:flutter/material.dart';

class AlertDlg {
  AlertDlg();

  Future<void> confirm({
    required String title,
    required String body,
    required BuildContext context,
    void Function()? cancelFunction,
    void Function()? confirmFunction,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(body),
          ),
          actions: [
            TextButton(
              onPressed: cancelFunction,
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: confirmFunction,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> alert({
    required String title,
    required String body,
    required BuildContext context,
    void Function()? confirmFunction,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: Text(body),
          ),
          actions: [
            TextButton(
              onPressed: confirmFunction,
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
