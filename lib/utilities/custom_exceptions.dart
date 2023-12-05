import 'package:flutter/foundation.dart';

abstract class CustomException implements Exception {
  CustomException({
    this.message,
    this.cause,
  });

  final String? message;
  final Object? cause;

  @override
  String toString() {
    final msg = message ?? 'Something went wrong';
    return kDebugMode ? '$msg\n' 'Cause: $cause' : msg;
  }
}

class ITunesSearchException extends CustomException {
  ITunesSearchException({
    super.message = 'Could not complete search request',
    super.cause,
  });
}

class AudioServicePlaybackException extends CustomException {
  AudioServicePlaybackException({
    super.message = 'Error playing audio',
    super.cause,
  });
}

class AudioServicePauseException extends CustomException {
  AudioServicePauseException({
    super.message = 'Error pausing audio',
    super.cause,
  });
}

class AudioServiceStopException extends CustomException {
  AudioServiceStopException({
    super.message = 'Error stopping audio',
    super.cause,
  });
}

class AudioServiceReleaseException extends CustomException {
  AudioServiceReleaseException({
    super.message = 'Error releasing audio',
    super.cause,
  });
}

class AudioServiceSeekException extends CustomException {
  AudioServiceSeekException({
    super.message = 'Error seeking audio',
    super.cause,
  });
}
