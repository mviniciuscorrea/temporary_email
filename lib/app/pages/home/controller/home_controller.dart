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
import 'package:email_temporario/app/global/widgets/snackbar_widget.dart';
import 'package:email_temporario/app/pages/home/repository/home_repository.dart';
import 'package:email_temporario/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import '../../../global/models/account.dart';
import '../../../global/widgets/alert_dialog_widget.dart';
import '../../../routes/app_routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class HomeController extends GetxController {
  HomeController({
    required HomeRepository homeRepository,
  }) : _homeRepository = homeRepository;

  final HomeRepository _homeRepository;
  final emailController = TextEditingController();
  final style = Style();
  final helper = Helper();
  AccountData account = Get.find();

  final _alertDlg = AlertDlg();

  RxString domainName = ''.obs;
  RxBool validAccount = false.obs;
  RxBool emailUnread = false.obs;
  RxInt selectedBottom = 0.obs;
  RxInt totalMailsToDelete = 0.obs;
  RxList<messages.HydraMember> listEmails = <messages.HydraMember>[].obs;

  bool disableTimer = true;
  bool showErrorNewEmail = true;

  @override
  void onReady() {
    disableTimer = true;
    getDomains();
    super.onReady();

    FlutterNativeSplash.remove();
  }

  void createRandomEmail() {
    emailController.text = 'email_${Random().nextInt(1000000) + 100}';
  }

  void getDomains() async {
    LoadingWidget.showLoadingDialog(Get.context!);

    listEmails.clear();
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

      _timerGetNewEmail();
    }

    print(account.token);
    print(account.address);

    LoadingWidget.closeDialog(Get.context!);
  }

  void createAccount() async {
    disableTimer = true;
    showErrorNewEmail = true;
    emailUnread.value = false;

    if (emailController.text.trim().isEmpty) {
      return _alertDlg.alert(
        title: 'Ooops',
        body: 'Informe um e-mail para nós criarmos :)',
        context: Get.context!,
        confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
      );
    }

    LoadingWidget.showLoadingDialog(Get.context!);
    listEmails.clear();

    final response = await _homeRepository.createAccount(
      address: emailController.text,
      pass: '123456',
      domain: domainName.value,
    );

    if (response.isNotEmpty) {
      final response = await _homeRepository.createToken();
      validAccount.value = response.isNotEmpty;
      LoadingWidget.closeDialog(Get.context!);

      if (validAccount.value) {
        _alertDlg.alert(
          title: 'Sucesso',
          body: 'Conta de e-mail criada!',
          context: Get.context!,
          confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
        );

        _timerGetNewEmail();
      } else {
        account.removeDataAccount();

        _alertDlg.alert(
          title: 'Ooops',
          body:
              'Não foi possível gerar um token, crie novamente um novo e-mail',
          context: Get.context!,
          confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
        );
      }
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
      showErrorNewEmail = true;
      int countNewEmails = 0;

      final modelAllMessages = messages.MessagesModel.fromJson(response);

      if (modelAllMessages.hydraMember.isNotEmpty) {
        if (listEmails.isEmpty) {
          listEmails.assignAll(
            modelAllMessages.hydraMember.where((e) => !e.isDeleted),
          );
        } else {
          for (var message in modelAllMessages.hydraMember) {
            listEmails.firstWhere(
                (element) => element.hydraMemberId == message.hydraMemberId,
                orElse: () {
              if (!message.isDeleted) {
                countNewEmails++;
                listEmails.insert(0, message);
              }
              return message;
            });
          }
        }

        _unreadEmails();
        update(['ListViewMail']);

        if (countNewEmails > 0) {
          SnackBarWidget.show(
            title: 'Novo email',
            message: countNewEmails == 1
                ? 'Um e-mail chegou em sua caixa'
                : '${countNewEmails} novos e-mails chegaram em sua caixa',
            icon: Icons.email,
          );
        }
      }

      if (showLoading) {
        LoadingWidget.closeDialog(Get.context!);
      }
    } else {
      if (showLoading) {
        LoadingWidget.closeDialog(Get.context!);
      }

      if (showErrorNewEmail) {
        showErrorNewEmail = false;

        _alertDlg.alert(
          title: 'Ooops',
          body:
              'Não foi possível verificar novos e-mails. Tente novamente mais tarde',
          context: Get.context!,
          confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
        );
      }
    }
  }

  _unreadEmails() {
    emailUnread.value = listEmails.indexWhere((e) => !e.seen) >= 0;
  }

  showMessageDetails(messages.HydraMember showDetailsMessage) async {
    disableTimer = true;

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
      )?.then(
        (result) {
          final response = result as Map<String, dynamic>;

          if (response["deleteEmail"] || response["seenEmail"]) {
            final index = listEmails.indexWhere(
              (e) => e.hydraMemberId == showDetailsMessage.hydraMemberId,
            );

            if (index >= 0) {
              if (response["deleteEmail"]) {
                listEmails.removeAt(index);
              } else if (response["seenEmail"]) {
                listEmails[index].seen = true;
              }

              _unreadEmails();
              update(['ListViewMail']);
              _timerGetNewEmail();
            } else {
              _timerGetNewEmail();
            }
          } else {
            _timerGetNewEmail();
          }
        },
      );
    } else {
      _timerGetNewEmail();

      _alertDlg.alert(
        title: 'Ooops',
        body: 'Não foi possível carregar o email. Tente novamente mais tarde',
        context: Get.context!,
        confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
      );
    }
  }

  messageDeleteEmails() {
    disableTimer = true;

    _alertDlg.confirm(
      title: 'Confirmar',
      body: 'Será excluído e-mails selecionados',
      context: Get.context!,
      cancelFunction: () {
        selectedBottom.value = 0;
        Navigator.pop(Get.context!, 'Cancel');
        _timerGetNewEmail();
      },
      confirmFunction: () {
        Navigator.pop(Get.context!, 'Ok');

        _deleteMessages();
      },
    );
  }

  void removeAndCreateNewAccount() async {
    disableTimer = true;

    _alertDlg.confirm(
      title: 'Confirmar',
      body: 'Será excluído endereço de e-mail para ser criado um novo!/n'
          'Irá levar um tempo para que esse mesmo endereço fique disponível',
      context: Get.context!,
      cancelFunction: () {
        selectedBottom.value = 0;
        Navigator.pop(Get.context!, 'Cancel');
        _timerGetNewEmail();
      },
      confirmFunction: () async {
        Navigator.pop(Get.context!, 'Ok');

        LoadingWidget.showLoadingDialog(Get.context!);
        final response = await _homeRepository.deleteAccount();
        LoadingWidget.closeDialog(Get.context!);

        if (response == 204) {
          await account.removeDataAccount();
          validAccount.value = false;
          listEmails.clear();
          emailController.text = "";

          update(['ListViewMail']);

          _alertDlg.alert(
            title: 'Sucesso',
            body: 'Conta de e-mail excluída',
            context: Get.context!,
            confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
          );
        } else {
          _alertDlg.alert(
            title: 'Ooops',
            body: 'Não foi possível excluir essa conta',
            context: Get.context!,
            confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
          );
        }
      },
    );
  }

  void copyToClipboard() async {
    await Clipboard.setData(
      ClipboardData(text: '${emailController.text}${domainName.value}'),
    );

    SnackBarWidget.show(
      title: 'Copiado',
      message: 'Endereço de e-mail copiado',
      icon: Icons.check_circle,
    );
  }

  void callSelectMailToDelete(int index) {
    disableTimer = true;
    listEmails[index].selected = !listEmails[index].selected;

    if (listEmails[index].selected) {
      totalMailsToDelete++;
    } else {
      totalMailsToDelete--;
    }

    update(['ListViewMail']);
    _timerGetNewEmail();
  }

  void clearListMailToDelete() {
    disableTimer = true;

    for (var i = 0; i < listEmails.length; i++) {
      listEmails[i].selected = false;
    }

    totalMailsToDelete.value = 0;
    update(['ListViewMail']);
    _timerGetNewEmail();
  }

  void _deleteMessages() async {
    LoadingWidget.showLoadingDialog(Get.context!);

    List<messages.HydraMember> emails = [];
    emails.assignAll(listEmails.where((e) => e.selected));

    for (var email in emails) {
      int response = await _homeRepository.deleteMessage(
        idMessage: email.hydraMemberId,
      );

      if (response == 204) {
        final index = listEmails.indexWhere(
          (element) => element.hydraMemberId == email.hydraMemberId,
        );

        if (index >= 0) {
          listEmails.removeAt(index);
        }
      }
    }

    totalMailsToDelete.value = 0;
    update(['ListViewMail']);

    LoadingWidget.closeDialog(Get.context!);
    _timerGetNewEmail();
  }

  void _timerGetNewEmail() {
    disableTimer = false;

    Timer.periodic(const Duration(seconds: 5), (timer) {
      if (disableTimer) {
        timer.cancel();
      } else {
        getAllMessages(showLoading: false);
      }
    });
  }
}
