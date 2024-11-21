import 'package:flutter/material.dart';
import 'package:music/services/android_player.dart';

class PlayerPage extends StatelessWidget {
  final String path;

  const PlayerPage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Music Player')),
        body: ListView(
          children: [
            ListTile(
              title: const Text("resume"),
              onTap: () {
                NativeAudioPlayer.resumeAudio();
              },
            ),
            ListTile(
              title: const Text("pause"),
              onTap: () {
                NativeAudioPlayer.pauseAudio();
              },
            ),
            ListTile(
              title: const Text("stop"),
              onTap: () {
                NativeAudioPlayer.stopAudio();
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }
}
