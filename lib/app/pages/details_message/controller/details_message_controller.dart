import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/message_base.dart';
import '../../../global/helper.dart';
import '../../../global/widgets/alert_dialog_widget.dart';
import '../../../global/widgets/loading_widget.dart';
import '../../../styles/style.dart';
import '../../home/repository/home_repository.dart';

class DetailsMessageController extends GetxController {
  DetailsMessageController({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;
  final style = Style();
  final helper = Helper();

  late MessageBase message;

  RxBool favorite = false.obs;
  bool seenEmail = false;

  @override
  void onInit() async {
    try {
      message = MessageBase.fromJson(Get.arguments[0] ?? {});
      seenEmail = message.message.seen;

      if (!seenEmail) {
        seenEmail = _homeRepository.setReadMessage(
              idMessage: message.message.messageDetailsId,
            ) ==
            200;
      }
    } catch (_) {
      Get.back(result: seenEmail);
    }

    super.onInit();
  }

  void toFavorite() {
    favorite.value = !favorite.value;
  }

  String loadHtmlFromAssets() {
    return message.message.html[0];
  }

  void backToHome() {
    Get.back(
      result: {"seenEmail": true, "deleteEmail": false},
    );
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

        await _homeRepository.deleteMessage(
          idMessage: message.message.messageDetailsId,
        );

        LoadingWidget.closeDialog(Get.context!);
        Get.back(result: {"seenEmail": seenEmail, "deleteEmail": true});
      },
    );
  }
}
