import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/message_base.dart';
import '../../../global/helper.dart';
import '../../../global/widgets/alert_dialog_widget.dart';
import '../../../global/widgets/loading_widget.dart';
import '../../../styles/style.dart';
import '../../home/repository/home_repository.dart';

class DetailsMessageController extends GetxController {
  DetailsMessageController();

  final style = Style();
  final _helper = Helper();

  late MessageBase message;

  RxBool favorite = false.obs;

  @override
  void onInit() async {
    try {
      message = MessageBase.fromJson(Get.arguments[0] ?? {});
    } catch (_) {
      Get.back();
    }

    super.onInit();
  }

  void toFavorite() {
    favorite.value = !favorite.value;
  }

  String formatDate(DateTime date) {
    return _helper.dateFormat(date);
  }

  String loadHtmlFromAssets() {
    return message.message.html[0];
  }

  void deleteMessage() {
    AlertDlg().confirm(
      title: 'Excluir?',
      body: 'Confirma a exclusão desse e-mail?',
      context: Get.context!,
      cancelFunction: () {
        Navigator.pop(Get.context!, 'Cancel');
      },
      confirmFunction: () async {
        Navigator.pop(Get.context!, 'Ok');
        LoadingWidget.showLoadingDialog(Get.context!);

        final homeRepository = HomeRepository();

        await homeRepository.deleteMessage(
          idMessage: message.message.messageDetailsId,
        );

        LoadingWidget.closeDialog(Get.context!);
        Get.back();
      },
    );
  }
}
