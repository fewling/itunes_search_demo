import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../controllers/search_page_controller.dart';
import 'search_mobile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchPageController());

    return ScreenTypeLayout.builder(
      mobile: (_) => SearchPageMobile(controller),
      tablet: (_) => SearchPageMobile(controller),
      desktop: (_) => SearchPageMobile(controller),
    );
  }
}
