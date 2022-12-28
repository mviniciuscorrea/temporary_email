import 'package:email_temporario/app/pages/details_message/controller/details_message_controller.dart';
import 'package:email_temporario/app/pages/details_message/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/widgets/alert_dialog_widget.dart';

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
              onPressed: () {
                // AlertDlg().confirm(
                //   title: 'Confirmar',
                //   body: 'Será excluído e-mails selecionados',
                //   context: context,
                //   cancelFunction: () {
                //     controller.selectedBottom.value = 0;
                //     Navigator.pop(context, 'Cancel');
                //   },
                //   confirmFunction: () {
                //     Navigator.pop(context, 'Ok');

                //     controller.deleteMessages();
                //   },
                // );
              },
            ),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: Get.back,
        ),
        backgroundColor: controller.style.colorPrimary(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: const [HeaderWidget()],
        ),
      ),
    );
  }
}
