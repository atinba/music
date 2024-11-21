import 'dart:io';
import 'package:flutter/material.dart';

import 'android_player.dart';

class AudioService extends ChangeNotifier {
  File? currentMedia;
  bool isPlaying = false;

  void play(File file) {
    NativeAudioPlayer.playAudio(file.path);
    currentMedia = file;
    isPlaying = true;
    notifyListeners();
  }

  void pause() {
    NativeAudioPlayer.pauseAudio();
    isPlaying = false;
    notifyListeners();
  }

  void resume() {
    NativeAudioPlayer.resumeAudio();
    isPlaying = true;
    notifyListeners();
  }

  void stop() {
    NativeAudioPlayer.stopAudio();
    currentMedia = null;
    isPlaying = false;
    notifyListeners();
  }

  void toggle() {
    isPlaying ? pause() : resume();
  }

  bool get isSongLoaded => currentMedia != null;
}
