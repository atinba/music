import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music/models/song.dart';
import 'package:music/widgets/custom_widgets.dart';
import 'package:music/widgets/mini_player.dart';

class SongList extends StatefulWidget {
  final String dirPath;

  const SongList({super.key, required this.dirPath});

  @override
  State<SongList> createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  List<Widget> widgets = [];

  @override
  void initState() {
    _listFiles(widget.dirPath);
    super.initState();
  }

  Future<void> _listFiles(String path) async {
    final directory = Directory(path);
    if (!await directory.exists()) {
      throw ErrorDescription('Directory does not exist');
    }

    final fileEntities = directory.listSync()
      ..sort((a, b) => a.path.toLowerCase().compareTo(b.path.toLowerCase()));

    final List<Widget> widgetList = [];
    widgetList.addAll(fileEntities
        .whereType<Directory>()
        .map((dir) => DirectoryEntry(dir: dir)));

    final Map<String, List<File>> songMap = {};

    fileEntities.whereType<File>().forEach((file) {
      // TODO: decide how to handle artist name different case
      final artist = file.path.split('/').last.split(' - ').first.toLowerCase();
      songMap.putIfAbsent(artist, () => []).add(file);
    });

    widgetList.addAll(songMap.entries.map((entry) {
      return entry.value.length == 1
          ? SongEntry(song: Song(file: entry.value.single))
          : ArtistSongList(
              songs: entry.value.map((file) => Song(file: file)).toList());
    }));

    setState(() {
      widgets = widgetList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: widgets,
      ),
      bottomNavigationBar: const MiniPlayer(),
    );
  }
}
