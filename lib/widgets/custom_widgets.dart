import 'dart:io';

import 'package:flutter/material.dart';
import 'package:music/pages/song_list.dart';
import 'package:music/services/audio_service.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';

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
            builder: (context) => SongList(dirPath: dir.path),
          ),
        );
      },
    );
  }
}

class SongEntry extends StatelessWidget {
  final Song song;

  const SongEntry({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.music_note_sharp),
      title: Text(song.displayName),
      onTap: () {
        final mediaProvider = Provider.of<AudioService>(context, listen: false);
        mediaProvider.play(song.file);
      },
    );
  }
}

class ArtistSongList extends StatelessWidget {
  final List<Song> songs;

  ArtistSongList({super.key, required this.songs}) {
    for (var song in songs) {
      song.displayName = song.fileName.split(' - ').skip(1).join(' - ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final artist = songs.first.artist;

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
          child: SongEntry(song: song),
        );
      }).toList(),
    );
  }
}
