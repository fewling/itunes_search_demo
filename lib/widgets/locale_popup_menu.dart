import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../controllers/settings_controller.dart';
import '../l10n/generated/l10n.dart';

class LocalePopupMenu extends StatelessWidget {
  const LocalePopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();

    return Obx(
      () {
        final locales =
            I10n.delegate.supportedLocales.where((e) => e.countryCode != null);
        final locale = settingsController.loc.value;

        return PopupMenuButton(
          tooltip: I10n.current.localeButtonTooltip,
          initialValue: locale,
          onSelected: (value) {
            settingsController.updateLocale(value);
            _promptRestart(context);
          },
          itemBuilder: (context) => [
            for (final loc in locales)
              PopupMenuItem(
                value: loc,
                child: Text(loc.toLanguageTag()),
              ),
          ],
        );
      },
    );
  }

  void _promptRestart(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final txtTheme = Theme.of(context).textTheme;

    showToastWidget(
      Container(
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Text(
            I10n.current.restartPrompt,
            style: txtTheme.titleMedium?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ),
      position: ToastPosition.bottom,
      duration: const Duration(seconds: 2),
    );
  }
}
