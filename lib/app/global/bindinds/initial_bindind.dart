import 'package:get/get.dart';

import '../models/account.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put(AccountData.create());
  }
}
