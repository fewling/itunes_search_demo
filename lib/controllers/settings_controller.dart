import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/generated/l10n.dart';

class SettingsController extends GetxController {
  static const _isDarkKey = 'isDark';
  static const _languageCodeKey = 'languageCode';
  static const _countryCodeKey = 'countryCode';

  late final SharedPreferences _prefs;

  final loc = Rxn<Locale>();

  final isDark = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    _prefs = await SharedPreferences.getInstance();
    isDark.value = _prefs.getBool(_isDarkKey) ?? false;

    final langCode = _prefs.getString(_languageCodeKey);
    final countryCode = _prefs.getString(_countryCodeKey);

    // If app locale is not specified, use system locale
    if (langCode == null) {
      final systemLocales = WidgetsBinding.instance.platformDispatcher.locales;
      loc.value = systemLocales.firstWhere(
        (e) => I10n.delegate.isSupported(e),
        orElse: () => const Locale('en'),
      );
    } else {
      loc.value = Locale(langCode, countryCode);
    }
  }

  void toggleBrightness() {
    _prefs
        .setBool(_isDarkKey, !isDark.value)
        .then((_) => isDark.value = !isDark.value);
  }

  Future<void> updateLocale(Locale? locale) async {
    if (locale == null) return;
    loc.value = locale;

    await _prefs.setString(_languageCodeKey, locale.languageCode);
    if (locale.countryCode != null) {
      await _prefs.setString(_countryCodeKey, locale.countryCode!);
    }
  }
}
