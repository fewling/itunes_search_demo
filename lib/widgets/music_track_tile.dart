import 'package:flutter/material.dart';

import '../models/itune_response.dart';

class MusicTrackTile extends StatelessWidget {
  const MusicTrackTile({
    required this.iTuneResult,
    this.onTap,
    this.isPlaying = false,
    super.key,
  });

  final ITuneResult iTuneResult;
  final VoidCallback? onTap;
  final bool isPlaying;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final txtTheme = Theme.of(context).textTheme;

    return Material(
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        selected: isPlaying,
        selectedColor: colorScheme.onSecondaryContainer,
        selectedTileColor: colorScheme.secondaryContainer,
        leading: iTuneResult.artworkUrl100 != null
            ? Image.network(iTuneResult.artworkUrl100!)
            : const Icon(Icons.music_note),
        title: Text(iTuneResult.trackName ?? ''),
        subtitle: Text(iTuneResult.artistName ?? ''),
        titleTextStyle: txtTheme.titleMedium?.copyWith(
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
