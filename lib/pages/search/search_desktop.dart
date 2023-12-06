import 'package:flutter/material.dart';

import '../../controllers/search_page_controller.dart';

/// The desktop version of the search page.
/// As for demonstration purposes, this page is not implemented.
/// Planned architecture is to have a single controller for both
/// mobile and desktop versions of the search page.
class SearchPageDesktop extends StatelessWidget {
  const SearchPageDesktop(this.controller, {super.key});

  final SearchPageController controller;

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('iTunes Search Demo'),
      ),
      body: Center(
        child: Text(
          'As for demonstration purposes, the \n'
          'desktop layout of the search page is not implemented.\n'
          'Please try the mobile layout.',
          style: txtTheme.headlineMedium,
        ),
      ),
    );
  }
}
