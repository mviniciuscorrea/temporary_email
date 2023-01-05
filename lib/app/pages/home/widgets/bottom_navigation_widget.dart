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
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(controller.emailUnread.value
                  ? Icons.mark_email_unread_outlined
                  : Icons.email_outlined),
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
                controller.removeAndCreateNewAccount();
                break;
            }
          },
        ),
      ),
    );
  }
}
