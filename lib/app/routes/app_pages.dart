import 'package:email_temporario/app/pages/details_message/bindings/details_message_binding.dart';
import 'package:email_temporario/app/pages/details_message/details_message_page.dart';
import 'package:email_temporario/app/pages/home/bindings/home_binding.dart';
import 'package:email_temporario/app/pages/home/home_page.dart';
import 'package:get/route_manager.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.detailsMessage,
      page: () => const DetailsMessagePage(),
      binding: DetailsBinding(),
    ),
  ];
}
