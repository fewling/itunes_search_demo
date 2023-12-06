import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/settings_controller.dart';
import '../l10n/generated/l10n.dart';

class BrightnessToggleIconButton extends StatelessWidget {
  const BrightnessToggleIconButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final appController = Get.find<SettingsController>();
      final isDark = appController.isDark.value;
      return IconButton(
        tooltip: I10n.current.brightnessButtonTooltip,
        onPressed: () => appController.toggleBrightness(),
        icon: isDark
            ? const Icon(Icons.dark_mode_outlined)
            : const Icon(Icons.light_mode_outlined),
      );
    });
  }
}
