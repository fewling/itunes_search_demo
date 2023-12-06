import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

import '../utilities/custom_exceptions.dart';

class AudioService {
  AudioService() {
    _player = AudioPlayer();
    _player.setVolume(kDebugMode ? 0.1 : 1.0);

    _player.processingStateStream.listen((processingState) {
      if (processingState == ProcessingState.completed) {
        _player.seek(Duration.zero);
        _player.pause();
      }
    });
  }

  late final AudioPlayer _player;

  Stream<bool> get playingStream => _player.playingStream;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;

  Stream<Duration> get positionStream => _player.positionStream;

  Stream<Duration?> get durationStream => _player.durationStream;

  Future<void> play(String url) async {
    try {
      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      throw CustomException(
        exceptionType: CustomExceptionType.audioServicePlay,
        cause: e,
      );
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e) {
      throw CustomException(
        exceptionType: CustomExceptionType.audioServicePlay,
        cause: e,
      );
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      throw CustomException(
        exceptionType: CustomExceptionType.audioServicePlay,
        cause: e,
      );
    }
  }

  Future<void> release() async {
    try {
      await _player.dispose();
    } catch (e) {
      throw CustomException(
        exceptionType: CustomExceptionType.audioServicePlay,
        cause: e,
      );
    }
  }

  Future<void> seek(Duration duration) async {
    try {
      await _player.seek(duration);
    } catch (e) {
      throw CustomException(
        exceptionType: CustomExceptionType.audioServicePlay,
        cause: e,
      );
    }
  }

  Future<void> toggle() {
    return _player.playing ? _player.pause() : _player.play();
  }
}
