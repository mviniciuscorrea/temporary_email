import 'package:email_temporario/app/global/bindinds/initial_bindind.dart';
import 'package:email_temporario/app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.home,
      defaultTransition: Transition.fadeIn,
      title: 'E-mail Temporario',
      theme: ThemeData(
        colorSchemeSeed: Style().colorPrimary(),
        useMaterial3: true,
        fontFamily: 'Raleway',
      ),
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
