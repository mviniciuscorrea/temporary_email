import 'package:email_temporario/app/pages/details_message/controller/details_message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HeaderWidget extends GetView<DetailsMessageController> {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                controller.message.message.subject,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: controller.style.textColor(),
                ),
              ),
            ),
            Obx(
              () => IconButton(
                onPressed: controller.toFavorite,
                icon: Icon(
                  controller.favorite.value ? Icons.star : Icons.star_border,
                  size: 30,
                ),
                color: Colors.amber,
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: controller.style.borderColor(),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Text(
              'Caixa de Entrada',
              style: TextStyle(
                fontSize: 12,
                letterSpacing: 0.8,
                fontWeight: FontWeight.w500,
                color: controller.style.borderColor(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        ListTile(
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Color(controller.message.colorAvatar),
            child: Text(
              controller.message.nameAvatar,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: controller.style.textColor(),
              ),
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 4,
                child: Text(
                  controller.message.message.from.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: controller.style.textColor(),
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  controller.formatDate(
                    controller.message.message.createdAt,
                  ),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ],
          ),
          subtitle: GestureDetector(
            child: Row(
              children: const [
                Text('para mim'),
                Icon(Icons.arrow_drop_down_sharp),
              ],
            ),
            onTap: () {},
          ),
        )
      ],
    );
  }
}
