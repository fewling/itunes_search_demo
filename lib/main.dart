import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:oktoast/oktoast.dart';

import 'pages/search/search_base.dart';
import 'services/audio_service.dart';
import 'services/itune_service.dart';
import 'utilities/custom_scroll_behaviour.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerLazySingleton(() => AudioService());
  GetIt.I.registerLazySingleton(() => ITuneService());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: MaterialApp(
        scrollBehavior: CustomScrollBehavior(),
        theme: ThemeData(useMaterial3: true),
        home: const SearchPage(),
      ),
    );
  }
}
