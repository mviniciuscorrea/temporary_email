import 'package:email_temporario/app/pages/home/repository/home_repository.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(
      HomeController(homeRepository: HomeRepository()),
    );
  }
}
