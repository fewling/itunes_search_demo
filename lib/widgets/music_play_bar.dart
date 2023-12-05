import 'package:flutter/material.dart';

class MusicPlayBar extends StatelessWidget {
  const MusicPlayBar({
    required this.thumbnail,
    required this.trackTitle,
    required this.artistName,
    super.key,
    this.position = Duration.zero,
    this.maxDuration = Duration.zero,
    this.isPlaying = false,
    this.onPlayTap,
    this.onSeek,
    this.playerReady,
  });

  /// The thumbnail of the track.
  /// Displayed on the left side of the play bar.
  final Widget thumbnail;

  /// The title of the track.
  final Widget trackTitle;

  /// The name of the artist.
  /// Displayed below the track title.
  final Widget artistName;

  /// The current position of the track.
  final Duration position;

  /// The maximum duration of the track.
  final Duration maxDuration;

  /// Whether the audio player is playing.
  /// If true, the play button will show a pause icon.
  /// If false, the play button will show a play icon.
  final bool isPlaying;

  /// Whether the audio player is loading.
  /// if true, the play button will be disabled.
  /// if false, the play button will be enabled.
  final bool? playerReady;

  /// Called when the user taps the play/pause button.
  final VoidCallback? onPlayTap;

  /// Called when the user drags the slider thumb to seek.
  /// [value] is the millisecond value of the position.
  final void Function(double value)? onSeek;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.primaryContainer,
      child: Wrap(
        children: [
          ListTile(
            leading: thumbnail,
            title: trackTitle,
            subtitle: artistName,
            trailing: IconButton.filledTonal(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: playerReady ?? false ? onPlayTap : null,
            ),
          ),
          Slider(
            value: position.inMilliseconds.toDouble(),
            max: maxDuration.inMilliseconds.toDouble(),
            inactiveColor: colorScheme.onPrimary,
            onChanged: onSeek,
          ),
        ],
      ),
    );
  }
}
