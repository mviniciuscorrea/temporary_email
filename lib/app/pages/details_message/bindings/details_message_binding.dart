import 'package:get/get.dart';

import '../controller/details_message_controller.dart';

class DetailsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      DetailsMessageController(),
    );
  }
}
