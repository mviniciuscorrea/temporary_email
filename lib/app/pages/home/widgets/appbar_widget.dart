import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../global/widgets/alert_dialog_widget.dart';
import '../controller/home_controller.dart';

class AppBarWidget extends GetView<HomeController> {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.totalMailsToDelete.value == 0
          ? AppBar(
              elevation: 0.4,
              title: Text(
                'Email Temporário',
                style: TextStyle(
                  color: controller.style.textWhiteColor(),
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
              automaticallyImplyLeading: true,
              centerTitle: true,
              backgroundColor: controller.style.colorPrimary(),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.info_outline,
                    color: controller.style.textWhiteColor(),
                  ),
                  onPressed: () => AlertDlg().alert(
                    title: 'Email Temporário',
                    body:
                        'É um endereço de e-mail temporário e completamente anónimo que não requer nenhum registro.'
                        '\n \nSua conta de e-mail é válida até que você a exclua manualmente ('
                        'os dados pessoais, o endereço em si e os e-mails são eliminados depois de eliminar a conta).'
                        '\n \nArmazenamos mensagens por apenas 7 dias. Desculpe-nos, não podemos armazená-los indefinidamente.',
                    context: context,
                    confirmFunction: () => Navigator.pop(Get.context!, 'Ok'),
                  ),
                ),
                const SizedBox(width: 15),
              ],
            )
          : AppBar(
              elevation: 0.4,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.totalMailsToDelete.value.toString(),
                    style: const TextStyle(
                      color: Color(0xFFF2F2F2),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                    onPressed: controller.messageDeleteEmails,
                  )
                ],
              ),
              automaticallyImplyLeading: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                color: Colors.white,
                onPressed: controller.clearListMailToDelete,
              ),
              backgroundColor: controller.style.colorPrimary(),
            ),
    );
  }
}
