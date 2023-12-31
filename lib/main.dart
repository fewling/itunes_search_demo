import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';

import 'controllers/settings_controller.dart';
import 'l10n/generated/l10n.dart';
import 'pages/search/search_base.dart';
import 'services/audio_service.dart';
import 'services/itune_service.dart';
import 'utilities/custom_scroll_behaviour.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerLazySingleton(() => AudioService());
  GetIt.I.registerLazySingleton(() => ITuneService());
  GetIt.I.registerLazySingleton(() => I10n());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Obx(() {
        final settingsController = Get.put(SettingsController());

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            I10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: I10n.delegate.supportedLocales,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            final isSupported = supportedLocales
                .map((e) => e.languageCode)
                .contains(deviceLocale?.languageCode);
            return isSupported ? deviceLocale : const Locale('en');
          },
          locale: settingsController.loc.value,
          scrollBehavior: CustomScrollBehavior(),
          theme: ThemeData(
            useMaterial3: true,
            brightness: settingsController.isDark.value
                ? Brightness.dark
                : Brightness.light,
          ),
          home: const SearchPage(),
        );
      }),
    );
  }
}
