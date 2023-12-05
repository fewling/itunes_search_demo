import 'dart:async';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:oktoast/oktoast.dart';

import '../../models/itune_response.dart';
import '../../services/audio_service.dart';
import '../../services/itune_service.dart';
import '../../utilities/custom_exceptions.dart';
import '../../widgets/error_toast_widget.dart';

/// A controller for the search pages (mobile and desktop)
/// This controller is responsible for handling the search logic and
/// playing the audio tracks.
class SearchPageController extends GetxController {
  late final ITuneService _iTuneService;
  late final AudioService _audioService;
  late final StreamSubscription<bool> _playingSubscription;
  late final StreamSubscription<PlayerState> _playerStateSubscription;
  late final StreamSubscription<Duration> _positionSubscription;
  late final StreamSubscription<Duration?> _durationSubscription;

  /// Whether the search is in progress.
  final isSearching = false.obs;

  /// The number of results returned from the search request.
  final resultCount = 0.obs;

  /// The list of results returned from the search request.
  final iTuneResults = <ITuneResult>[].obs;

  /// Whether the audio player is playing.
  final isPlaying = false.obs;

  /// The current processing state of the audio player.
  /// See [ProcessingState] for more details.
  final processingState = ProcessingState.idle.obs;

  /// The current position of the audio player.
  final position = Duration.zero.obs;

  /// The maximum duration of the audio player.
  final duration = Duration.zero.obs;

  /// The currently selected track.
  final currentTrack = Rxn<ITuneResult>();

  @override
  void onInit() {
    super.onInit();

    _iTuneService = GetIt.I.get<ITuneService>();
    _audioService = GetIt.I.get<AudioService>();

    _playingSubscription = _audioService.playingStream.listen((isPlaying) {
      this.isPlaying.value = isPlaying;
    });

    _playerStateSubscription =
        _audioService.playerStateStream.listen((playerState) {
      processingState.value = playerState.processingState;
    });

    _positionSubscription = _audioService.positionStream.listen((position) {
      this.position.value = position;
    });

    _durationSubscription = _audioService.durationStream.listen((duration) {
      this.duration.value = duration ?? Duration.zero;
    });
  }

  @override
  void onClose() {
    _playingSubscription.cancel();
    _playerStateSubscription.cancel();
    _positionSubscription.cancel();
    _durationSubscription.cancel();
    _audioService.release();
    super.onClose();
  }

  /// Searches for music tracks based on the given [terms].
  /// Toggles [isSearching] when the search starts and ends.
  /// Updates [resultCount] and [iTuneResults] when the search completes.
  Future<void> search(String terms) async {
    if (terms.isEmpty) return;

    // Tag the start time of the search
    final start = DateTime.now();

    isSearching.value = true;

    try {
      final response = await _iTuneService.fetchMusicTrack(terms);

      resultCount.value = response.resultCount;
      iTuneResults.value = response.results;
    } catch (e) {
      final exception = ITunesSearchException(
        message: 'Error searching for music',
        cause: e,
      );
      _showErrorToast(exception);
    } finally {
      // Find the elapsed time of the search
      final end = DateTime.now();
      final elapsed = end.difference(start);
      const maxGap = Duration(seconds: 2);

      // Prevent the loading widget from flashing
      if (elapsed < maxGap) {
        await Future.delayed(maxGap - elapsed);
      }
      isSearching.value = false;
    }
  }

  /// Plays the track from given [ITuneResult].
  Future<void> play(ITuneResult result) async {
    if (result.previewUrl == null) return;

    currentTrack.value = result;
    try {
      await _audioService.play(result.previewUrl!);
    } catch (e) {
      final exception = AudioServicePlaybackException(cause: e);
      _showErrorToast(exception);
    }
  }

  /// Toggle the play state of the audio player.
  Future<void> togglePlay() async {
    try {
      await _audioService.toggle();
    } catch (e) {
      final exception = AudioServicePlaybackException(cause: e);
      _showErrorToast(exception);
    }
  }

  /// Seeks the audio player to the given [value].
  /// The [value] should be in milliseconds and within the range of the
  /// current track's duration.
  Future<void> seek(double value) async {
    final position = Duration(milliseconds: value.toInt());

    try {
      await _audioService.seek(position);
    } catch (e) {
      final exception = AudioServiceSeekException(cause: e);
      _showErrorToast(exception);
    }
  }

  /// Shows an error toast with the given [exception].
  void _showErrorToast(CustomException exception) {
    showToastWidget(
      ErrorToastWidget(exception: exception),
      position: ToastPosition.bottom,
      duration: const Duration(seconds: 4),
    );
  }
}
