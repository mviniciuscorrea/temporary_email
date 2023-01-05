import 'package:email_temporario/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackBarWidget {
  static show({
    required String title,
    required String message,
    required IconData icon,
  }) {
    final _style = Style();

    Get.snackbar(
      '',
      '',
      backgroundColor: Colors.black54,
      titleText: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: _style.backgroundColor(),
          ),
        ),
      ),
      messageText: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: _style.backgroundColor(),
          ),
        ),
      ),
      icon: Icon(icon, color: _style.colorPrimary()),
    );
  }
}
