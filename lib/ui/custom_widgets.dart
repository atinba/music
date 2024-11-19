import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music/native_player.dart';
import 'package:music/ui/player.dart';

import '../main.dart';

class DirectoryEntry extends StatelessWidget {
  final Directory dir;

  const DirectoryEntry({super.key, required this.dir});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.folder_sharp),
      title: Text(dir.path.split('/').last),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(path: dir.path),
          ),
        );
      },
    );
  }
}

class FileEntry extends StatelessWidget {
  final File file;
  final bool splitName;

  const FileEntry({super.key, required this.file, this.splitName = false});

  @override
  Widget build(BuildContext context) {
    final fileName = file.path.split('/').last;
    final title =
        splitName ? fileName.split(' - ').skip(1).join(' - ') : fileName;

    return ListTile(
      leading: const Icon(Icons.music_note_sharp),
      title: Text(title),
      onTap: () {
        NativeAudioPlayer.playAudio(file.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerPage(path: file.path),
          ),
        );
      },
    );
  }
}

class ArtistSongList extends StatelessWidget {
  final List<File> songs;

  const ArtistSongList({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    final artist = songs.first.path.split('/').last.split(' - ').first.toUpperCase();
    return ExpansionTile(
      leading: const Icon(Icons.library_music_sharp),
      dense: true,
      title: ListTile(
        title: Text(
          artist,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      initiallyExpanded: true,
      children: songs.map((song) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: FileEntry(file: song, splitName: true),
        );
      }).toList(),
    );
  }
}
