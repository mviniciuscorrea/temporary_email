import 'package:email_temporario/app/pages/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ListEmailsWidget extends StatelessWidget {
  const ListEmailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: GetBuilder<HomeController>(
        id: 'ListViewMail',
        builder: ((controller) {
          return RefreshIndicator(
            onRefresh: () => controller.getAllMessages(showLoading: false),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.listEmails.length,
              itemBuilder: (_, index) {
                return ListTile(
                  onLongPress: () => controller.callSelectMailToDelete(index),
                  onTap: () => controller.totalMailsToDelete.value > 0
                      ? controller.callSelectMailToDelete(index)
                      : controller.showMessageDetails(
                          controller.listEmails[index],
                        ),
                  tileColor: controller.listEmails[index].selected
                      ? Colors.grey[300]
                      : Colors.transparent,
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundColor: controller.listEmails[index].colorAvatar,
                    child: controller.listEmails[index].selected
                        ? Icon(
                            Icons.check,
                            color: controller.style.textColor(),
                          )
                        : Text(
                            controller.listEmails[index].nameAvatar,
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
                          controller.listEmails[index].from.name,
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
                            controller.listEmails[index].createdAt,
                          ),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    controller.listEmails[index].subject,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
