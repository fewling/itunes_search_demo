import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../l10n/generated/l10n.dart';

class MusicSearchBar extends StatefulWidget {
  const MusicSearchBar({
    super.key,
    this.onSearch,
  });

  final void Function(String query)? onSearch;

  @override
  State<MusicSearchBar> createState() => _MusicSearchBarState();
}

class _MusicSearchBarState extends State<MusicSearchBar> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = GetIt.I.get<I10n>();

    return SearchBar(
      controller: _searchController,
      hintText: l10n.searchHint,
      onSubmitted: widget.onSearch,
      trailing: [
        IconButton(
          tooltip: l10n.clearAllTooltip,
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
          },
        ),
        IconButton(
          tooltip: l10n.searchButtonTooltip,
          onPressed: () => widget.onSearch?.call(_searchController.text),
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
