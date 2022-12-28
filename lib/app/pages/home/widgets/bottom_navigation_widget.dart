import 'package:email_temporario/app/global/widgets/alert_dialog_widget.dart';
import 'package:email_temporario/app/pages/home/controller/home_controller.dart';
import 'package:email_temporario/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class BottomNavigationWidget extends GetView<HomeController> {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.validAccount.value,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.email_outlined),
              label: 'Entrada',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.alternate_email_sharp),
              label: 'Novo endereço',
            ),
          ],
          currentIndex: controller.selectedBottom.value,
          selectedItemColor: Style().colorPrimary(),
          onTap: (int index) {
            controller.selectedBottom.value = index;

            switch (index) {
              case 0:
                break;
              case 1:
                AlertDlg().confirm(
                  title: 'Confirmar',
                  body:
                      'Será excluído endereço de e-mail para ser criado um novo!',
                  context: context,
                  cancelFunction: () {
                    controller.selectedBottom.value = 0;
                    Navigator.pop(context, 'Cancel');
                  },
                  confirmFunction: () async {
                    Navigator.pop(context, 'Ok');

                    controller.removeAndCreateNewAccount().then((deleted) {
                      if (deleted) {
                        AlertDlg().alert(
                          title: 'Sucesso',
                          body: 'Conta de e-mail excluída',
                          context: context,
                          confirmFunction: () => Navigator.pop(context, 'Ok'),
                        );
                      } else {
                        AlertDlg().alert(
                          title: 'Ooops',
                          body: 'Não foi possível excluir essa conta',
                          context: context,
                          confirmFunction: () => Navigator.pop(context, 'Ok'),
                        );
                      }
                    });
                  },
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
