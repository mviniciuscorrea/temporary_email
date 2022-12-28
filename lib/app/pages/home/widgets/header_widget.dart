import 'package:email_temporario/app/global/widgets/action_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/home_controller.dart';

class HeaderWidget extends GetView<HomeController> {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 135,
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Endereço de e-mail',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: controller.style.textColor(),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: controller.style.borderColor(),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    flex: 8,
                    child: Obx(
                      () => TextField(
                        enabled: !controller.validAccount.value,
                        controller: controller.emailController,
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                          fontSize: 18,
                          color: controller.style.textColor(),
                        ),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'e-mail',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(left: 12),
                            child: Icon(
                              Icons.email,
                              color: controller.style.borderColor(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    flex: 4,
                    child: Obx(() => Text(
                          controller.domainName.value,
                          style: TextStyle(
                            color: controller.style.textColor(),
                          ),
                        )),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: controller.validAccount.value
                          ? () {
                              controller.copyToClipboard();
                              Get.snackbar(
                                  'Copiado', "Endereço de e-mail copiado");
                            }
                          : () => controller.createRandomEmail(),
                      icon: Icon(
                        controller.validAccount.value
                            ? Icons.copy
                            : Icons.refresh,
                        color: controller.style.colorPrimary(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Obx(
              () => Visibility(
                visible: !controller.validAccount.value,
                child: ActionButtonWidget(
                  title: 'Criar e-mail',
                  function: controller.createAccount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
