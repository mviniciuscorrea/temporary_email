import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Helper {
  String getInitialsText(String text) {
    if (text.trim().isEmpty) {
      return '';
    } else {
      String initials = text.trim().substring(0, 1).toUpperCase();
      List<String> aux = text.trim().split(' ');

      if (aux.isNotEmpty && aux.length > 1 && aux.last.trim().isNotEmpty) {
        initials += aux.last.trim().substring(0, 1).toUpperCase();
      }
      return initials;
    }
  }

  Color shuffleColor() {
    List colors = [
      Colors.blue[300],
      Colors.blueGrey[300],
      Colors.brown[300],
      Colors.cyan[300],
      Colors.deepOrange[300],
      Colors.deepPurple[200],
      Colors.green[300],
      Colors.indigo[200],
      Colors.lightBlue[200],
      Colors.lightGreen[300],
      Colors.lime,
      Colors.orange,
      Colors.pink[200],
      Colors.teal[300],
      Colors.amber[900],
      Colors.amberAccent
    ];

    return colors[Random().nextInt(colors.length)];
  }

  String dateFormat(DateTime date) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal());
    final dateEmail = DateFormat('yyyy-MM-dd').format(date.toLocal());

    final formatedDate = dateEmail.compareTo(today) == 0
        ? DateFormat('HH:mm').format(date.toLocal())
        : DateFormat("dd 'de' MMM" '.', "pt_BR").format(date.toLocal());

    return formatedDate;
  }
}
