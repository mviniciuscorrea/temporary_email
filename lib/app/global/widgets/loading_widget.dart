import 'package:flutter/material.dart';

class LoadingWidget {
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const SimpleDialog(
            backgroundColor: Colors.black54,
            children: [
              Padding(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static closeDialog(BuildContext context) {
    Navigator.pop(context, 'Cancel');
  }
}
