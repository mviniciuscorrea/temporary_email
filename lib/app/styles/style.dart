import 'package:flutter/material.dart';

class Style {
  Color backgroundColor() {
    return const Color(0xFFF2F2F2);
  }

  Color colorSecondary() {
    return Colors.red;
  }

  Color colorPrimary() {
    return const Color(0xFFEF3844);
  }

  Color borderColor() {
    return const Color(0xFFB8B7B7);
  }

  Color textColor() {
    return const Color(0xFF4F4F4F);
  }

  Color textWhiteColor() {
    return backgroundColor();
  }

  BorderRadius borderInput() {
    return BorderRadius.circular(20.0);
  }
}
