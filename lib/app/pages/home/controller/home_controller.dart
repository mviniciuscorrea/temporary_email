import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:email_temporario/app/data/models/domains_model.dart';
import 'package:email_temporario/app/data/models/message_base.dart';
import 'package:email_temporario/app/data/models/message_details.dart';
import 'package:email_temporario/app/data/models/messages_model.dart'
    as messages;
import 'package:email_temporario/app/global/helper.dart';
import 'package:email_temporario/app/global/widgets/loading_widget.dart';
import 'package:email_temporario/app/pages/home/repository/home_repository.dart';
import 'package:email_temporario/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../global/models/account.dart';
import '../../../global/widgets/alert_dialog_widget.dart';
import '../../../routes/app_routes.dart';

class HomeController extends GetxController {
  HomeController({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;
  final emailController = TextEditingController();
  final style = Style();
  final _helper = Helper();
  AccountData account = Get.find();

  final _alertDlg = AlertDlg();

  RxString domainName = ''.obs;
  RxBool validAccount = false.obs;

  RxInt selectedBottom = 0.obs;
  RxInt totalMailsToDelete = 0.obs;
  RxList<messages.HydraMember> listEmails = <messages.HydraMember>[].obs;

  @override
  void onReady() {
    getDomains();

    super.onReady();

    // timerGetNewEmail();
  }

  void createRandomEmail() {
    emailController.text = 'email_${Random().nextInt(1000000) + 100}';
  }

  void getDomains() async {
    LoadingWidget.showLoadingDialog(Get.context!);
    await account.loadData();

    validAccount.value = account.isValidAccount();

    if (!validAccount.value) {
      await account.removeDataAccount();

      final response = await _homeRepository.getDomains();

      if (response.isNotEmpty) {
        final modelDomain = DomainModel.fromJson(response);

        domainName.value = '@${modelDomain.hydraMember[0].domain}';
      }
    } else {
      domainName.value = account.domain;
      emailController.text = account.address;
      getAllMessages();
    }

    print(account.token);
    print(account.address);

    LoadingWidget.closeDialog(Get.context!);
  }

  void createAccount() async {
    LoadingWidget.showLoadingDialog(Get.context!);

    // final address = '${emailController.text}${domainName.value}';
    // const pass = '123456';

    final response = await _homeRepository.createAccount(
      address: emailController.text,
      pass: '123456',
      domain: domainName.value,
    );

    if (response.isNotEmpty) {
      final response = await _homeRepository.createToken();
      validAccount.value = response.isNotEmpty;
      LoadingWidget.closeDialog(Get.context!);
    } else {
      await account.removeDataAccount();
      LoadingWidget.closeDialog(Get.context!);

      _alertDlg.alert(
        title: 'Ooops',
        body: 'Conta de e-mail ja está sendo utilizada',
        context: Get.context!,
        confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
      );
    }
  }

  Future getAllMessages({bool showLoading = true}) async {
    if (showLoading) {
      LoadingWidget.showLoadingDialog(Get.context!);
    }
    final response = await _homeRepository.getAllMessages();

    if (response.isNotEmpty) {
      //listEmails.clear();

      final modelAllMessages = messages.MessagesModel.fromJson(response);

      for (var e in modelAllMessages.hydraMember) {
        listEmails.add(e);
      }

      // listEmails.assignAll(
      //   modelAllMessages.hydraMember.where((e) => !e.isDeleted),
      // );

      update(['ListViewMail']);

      if (showLoading) {
        LoadingWidget.closeDialog(Get.context!);
      }
    } else {
      if (showLoading) {
        LoadingWidget.closeDialog(Get.context!);
      }
      _alertDlg.alert(
        title: 'Ooops',
        body:
            'Não foi possível verificar novos e-mails. Tente novamente mais tarde',
        context: Get.context!,
        confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
      );
    }
  }

  showMessageDetails(messages.HydraMember showDetailsMessage) async {
    final response = await _homeRepository.getMessage(
      idMessage: showDetailsMessage.hydraMemberId,
    );

    if (response.isNotEmpty) {
      final message = json.decode(
        messageBaseToJson(
          MessageBase(
            colorAvatar: showDetailsMessage.colorAvatar.value,
            nameAvatar: showDetailsMessage.nameAvatar,
            message: MessageDetails.fromJson(response),
          ),
        ),
      );

      Get.toNamed(
        Routes.detailsMessage,
        arguments: [message],
      );
    } else {
      _alertDlg.alert(
        title: 'Ooops',
        body: 'Não foi possível carregar o email. Tente novamente mais tarde',
        context: Get.context!,
        confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
      );
    }
  }

  Future<bool> removeAndCreateNewAccount() async {
    LoadingWidget.showLoadingDialog(Get.context!);

    final response = await _homeRepository.deleteAccount();

    if (response == 204) {
      await account.removeDataAccount();
      validAccount.value = false;
    }

    LoadingWidget.closeDialog(Get.context!);
    return !validAccount.value;
  }

  void copyToClipboard() async {
    await Clipboard.setData(
      ClipboardData(text: '${emailController.text}${domainName.value}'),
    );
  }

  String formatDate(DateTime date) {
    return _helper.dateFormat(date);
  }

  void callSelectMailToDelete(int index) {
    listEmails[index].selected = !listEmails[index].selected;

    if (listEmails[index].selected) {
      totalMailsToDelete++;
    } else {
      totalMailsToDelete--;
    }

    update(['ListViewMail']);
  }

  void clearListMailToDelete() {
    for (var i = 0; i < listEmails.length; i++) {
      listEmails[i].selected = false;
    }

    totalMailsToDelete.value = 0;
    update(['ListViewMail']);
  }

  void deleteMessages() {
    LoadingWidget.showLoadingDialog(Get.context!);

    for (var i = 0; i < listEmails.length; i++) {
      if (listEmails[i].selected) {
        _homeRepository.deleteMessage(idMessage: listEmails[i].hydraMemberId);
        listEmails.removeAt(i);
      }
    }

    totalMailsToDelete.value = 0;
    update(['ListViewMail']);

    LoadingWidget.closeDialog(Get.context!);
  }

  void _timerGetNewEmail() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      getAllMessages(showLoading: false);
    });
  }
}
