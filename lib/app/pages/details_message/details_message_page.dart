import 'package:email_temporario/app/pages/details_message/controller/details_message_controller.dart';
import 'package:email_temporario/app/pages/details_message/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';

class DetailsMessagePage extends GetView<DetailsMessageController> {
  const DetailsMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.style.backgroundColor(),
      appBar: AppBar(
        elevation: 0.4,
        automaticallyImplyLeading: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.white,
              onPressed: controller.deleteMessage,
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: controller.backToHome,
        ),
        backgroundColor: controller.style.colorPrimary(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const HeaderWidget(),
              Container(
                width: MediaQuery.of(context).size.width,
                child: HtmlWidget(
                  controller.loadHtmlFromAssets(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
