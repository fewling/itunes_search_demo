import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

import '../../controllers/search_page_controller.dart';
import '../../gen/assets.gen.dart';
import '../../models/itune_response.dart';
import '../../widgets/brightness_toggle_button.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/locale_popup_menu.dart';
import '../../widgets/music_play_bar.dart';
import '../../widgets/music_search_bar.dart';
import '../../widgets/music_track_tile.dart';

class SearchPageMobile extends StatelessWidget {
  const SearchPageMobile(this.controller, {super.key});

  final SearchPageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iTunes Search Demo'),
        actions: const [
          BrightnessToggleIconButton(),
          LocalePopupMenu(),
        ],
      ),
      body: Obx(
        () {
          // Add 1 to `itemCount` to account for the search bar
          final isLoading = controller.isSearching.value;
          final itemCount = isLoading ? 1 : controller.resultCount.value + 1;

          return Stack(
            children: [
              _SearchResultList(
                key: ObjectKey(controller.iTuneResults.value),
                iTuneResults: controller.iTuneResults.value,
                playingTrackId: controller.currentTrack.value?.trackId,
                onSearch: controller.search,
                onItemTap: controller.play,
              ),
              if (isLoading) const Align(child: LoadingWidget()),
              if (itemCount == 1 && !isLoading)
                Align(child: Lottie.asset(Assets.lottie.empty)),
            ],
          );
        },
      ),
      bottomNavigationBar: Obx(
        () {
          final currentTrack = controller.currentTrack;
          final processingState = controller.processingState.value;

          final noTrackSelected = currentTrack.value?.trackId == null;
          final playerReady = processingState == ProcessingState.ready ||
              processingState == ProcessingState.completed;

          return noTrackSelected
              ? const SizedBox.shrink()
              : MusicPlayBar(
                  position: controller.position.value,
                  maxDuration: controller.duration.value,
                  playerReady: playerReady,
                  isPlaying: controller.isPlaying.value,
                  thumbnail: currentTrack.value?.artworkUrl100 != null
                      ? Image.network(currentTrack.value!.artworkUrl100!)
                      : const Icon(Icons.music_note),
                  trackTitle: currentTrack.value?.trackName != null
                      ? Text(currentTrack.value!.trackName!)
                      : const SizedBox.shrink(),
                  artistName: currentTrack.value?.artistName != null
                      ? Text(currentTrack.value!.artistName!)
                      : const SizedBox.shrink(),
                  onPlayTap: controller.togglePlay,
                  onSeek: controller.seek,
                );
        },
      ),
    );
  }
}

class _SearchResultList extends StatelessWidget {
  const _SearchResultList({
    required this.iTuneResults,
    this.onSearch,
    this.onItemTap,
    this.playingTrackId,
    super.key,
  });

  final List<ITuneResult> iTuneResults;
  final int? playingTrackId;
  final void Function(String query)? onSearch;
  final void Function(ITuneResult iTuneResult)? onItemTap;

  @override
  Widget build(BuildContext context) {
    final options = LiveOptions(
      showItemInterval: 50.milliseconds,
      showItemDuration: 500.milliseconds,
      visibleFraction: 0.05,
    );

    return LiveList.options(
      itemCount: iTuneResults.length + 1,
      options: options,
      itemBuilder: (context, index, animation) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: MusicSearchBar(onSearch: onSearch),
          );
        }

        final iTuneResult = iTuneResults[index - 1];
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: Curves.fastOutSlowIn,
          ),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutBack,
            )),
            child: MusicTrackTile(
              iTuneResult: iTuneResult,
              onTap: () => onItemTap?.call(iTuneResult),
              isPlaying: playingTrackId == iTuneResult.trackId,
            ),
          ),
        );
      },
    );
  }
}
