import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../l10n/generated/l10n.dart';

final _l10n = GetIt.I.get<I10n>();

enum CustomExceptionType {
  iTunesSearch,
  audioServicePlay,
  audioServicePause,
  audioServiceRelease,
  audioServiceSeek,
}

class CustomException implements Exception {
  CustomException({
    required this.exceptionType,
    this.cause,
  });

  final CustomExceptionType exceptionType;
  final Object? cause;

  @override
  String toString() {
    final msg = switch (exceptionType) {
      CustomExceptionType.iTunesSearch => _l10n.iTuneSearchErrorMessage,
      CustomExceptionType.audioServicePlay => _l10n.audioPlayErrorMsg,
      CustomExceptionType.audioServicePause => _l10n.audioPauseErrorMsg,
      CustomExceptionType.audioServiceRelease => _l10n.audioReleaseErrorMsg,
      CustomExceptionType.audioServiceSeek => _l10n.audioSeekErrorMsg,
    };

    return kDebugMode ? '$msg\n' 'Cause: $cause' : msg;
  }
}
