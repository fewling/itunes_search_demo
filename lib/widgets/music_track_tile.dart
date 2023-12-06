import 'package:flutter/material.dart';

import '../models/itune_response.dart';

class MusicTrackTile extends StatefulWidget {
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
  State<MusicTrackTile> createState() => _MusicTrackTileState();
}

class _MusicTrackTileState extends State<MusicTrackTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final txtTheme = Theme.of(context).textTheme;

    return SlideTransition(
      position: Tween(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutBack,
      )),
      child: Material(
        elevation: 2,
        child: ListTile(
          onTap: widget.onTap,
          selected: widget.isPlaying,
          selectedColor: colorScheme.onSecondaryContainer,
          selectedTileColor: colorScheme.secondaryContainer,
          leading: widget.iTuneResult.artworkUrl100 != null
              ? Image.network(widget.iTuneResult.artworkUrl100!)
              : const Icon(Icons.music_note),
          title: Text(widget.iTuneResult.trackName ?? ''),
          subtitle: Text(widget.iTuneResult.artistName ?? ''),
          titleTextStyle: txtTheme.titleMedium?.copyWith(
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    );
  }
}
