import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:music/services/audio_service.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MiniPlayerState();
  }
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AudioService>(builder: (context, provider, child) {
      if (provider.isSongLoaded) {
        return _buildMiniPlayer(provider);
      }

      return const SizedBox.shrink();
    });
  }

  Widget _buildMiniPlayer(AudioService provider) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  provider.currentMedia!.path.split('/').last,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  provider.currentMedia!.path
                      .split('/')
                      .last
                      .split(' - ')
                      .first,
                  style: TextStyle(color: Colors.grey[400], fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          IconButton(
            icon: Icon(
              provider.isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              provider.toggle();
            },
          ),

          // Stop Button
          IconButton(
            icon: const Icon(Icons.stop, color: Colors.white),
            onPressed: () {
              provider.stop();
            },
          ),
        ],
      ),
    );
  }
}
