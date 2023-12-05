import 'package:flutter/material.dart';

import '../utilities/custom_exceptions.dart';

class ErrorToastWidget extends StatelessWidget {
  const ErrorToastWidget({
    required this.exception,
    super.key,
  });

  final CustomException exception;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true),
      child: Builder(builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;

        return Card(
          color: colorScheme.error,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: colorScheme.onError),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    exception.toString(),
                    style: TextStyle(color: colorScheme.onError),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
