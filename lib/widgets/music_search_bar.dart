import 'package:flutter/material.dart';

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
    return SearchBar(
      controller: _searchController,
      hintText: 'Search',
      onSubmitted: widget.onSearch,
      trailing: [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            _searchController.clear();
          },
        ),
        IconButton(
          onPressed: () => widget.onSearch?.call(_searchController.text),
          icon: const Icon(Icons.search),
        ),
      ],
    );
  }
}
