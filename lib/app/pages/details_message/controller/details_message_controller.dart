import 'package:get/get.dart';
import '../../../data/models/message_base.dart';
import '../../../global/helper.dart';
import '../../../styles/style.dart';

class DetailsMessageController extends GetxController {
  DetailsMessageController();

  final style = Style();
  final _helper = Helper();

  late MessageBase message;

  RxBool favorite = false.obs;

  @override
  void onInit() async {
    try {
      message = MessageBase.fromJson(Get.arguments[0] ?? {});
    } catch (_) {
      Get.back();
    }

    super.onInit();
  }

  void toFavorite() {
    favorite.value = !favorite.value;
  }

  String formatDate(DateTime date) {
    return _helper.dateFormat(date);
  }
}
