import 'package:email_temporario/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActionButtonWidget extends StatefulWidget {
  final String title;
  final Function? function;
  final Color? color;
  final Color textColor;
  final bool isInvertedColors;
  final double height;
  final double borderRadius;

  const ActionButtonWidget(
      {Key? key,
      required this.title,
      this.function,
      this.color,
      this.textColor = Colors.white,
      this.height = 48,
      this.borderRadius = 4,
      this.isInvertedColors = false})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ActionButtonWidget();
}

class _ActionButtonWidget extends State<ActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: Get.width,
      child: ElevatedButton(
        onPressed: (widget.function != null) ? () => widget.function!() : null,
        style: ElevatedButton.styleFrom(
            shape: widget.isInvertedColors
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    side: BorderSide(
                      color: widget.color ?? Style().colorPrimary(),
                      width: 1,
                    ),
                  )
                : null,
            backgroundColor:
                widget.isInvertedColors ? Colors.white : Style().colorPrimary(),
            elevation: 0,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 8)),
        child: Text(
          widget.title,
          style: Get.textTheme.button?.copyWith(
              color: widget.isInvertedColors ? widget.color : widget.textColor),
        ),
      ),
    );
  }
}
