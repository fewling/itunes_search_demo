import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';

import '../../gen/assets.gen.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/music_play_bar.dart';
import '../../widgets/music_search_bar.dart';
import '../../widgets/music_track_tile.dart';
import 'search_page_controller.dart';

class SearchPageMobile extends StatelessWidget {
  const SearchPageMobile(this.controller, {super.key});

  final SearchPageController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('iTunes Search Demo'),
      ),
      body: Obx(
        () {
          // Add 1 to `itemCount` to account for the search bar
          final isLoading = controller.isSearching.value;
          final itemCount = isLoading ? 1 : controller.resultCount.value + 1;

          return Stack(
            children: [
              _SearchResultList(
                itemCount: itemCount,
                controller: controller,
              ),
              if (isLoading) const Align(child: LoadingWidget()),
              if (itemCount == 1 && !isLoading)
                Align(
                  child: Lottie.asset(Assets.lottie.empty),
                ),
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
    required this.itemCount,
    required this.controller,
  });

  final int itemCount;
  final SearchPageController controller;

  @override
  Widget build(BuildContext context) {
    final options = LiveOptions(
      showItemInterval: 100.milliseconds,
      showItemDuration: 500.milliseconds,
      visibleFraction: 0.05,
      reAnimateOnVisibility: true,
    );

    return LiveList.options(
      key: ObjectKey(controller.iTuneResults),
      itemCount: itemCount,
      options: options,
      itemBuilder: (context, index, animation) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 8,
            ),
            child: MusicSearchBar(onSearch: controller.search),
          );
        }

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
            child: Obx(
              () {
                final iTuneResult = controller.iTuneResults[index - 1];
                final trackId = controller.currentTrack.value?.trackId;
                final isCurrentTrack = trackId == iTuneResult.trackId;
                return MusicTrackTile(
                  key: ObjectKey(iTuneResult),
                  iTuneResult: iTuneResult,
                  onTap: () => controller.play(iTuneResult),
                  isPlaying: isCurrentTrack,
                );
              },
            ),
          ),
        );
      },
    );
  }
}