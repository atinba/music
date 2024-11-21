import 'package:flutter/services.dart';

class NativeAudioPlayer {
  static const MethodChannel _channel = MethodChannel('com.example/media3');

  static Future<void> playAudio(String url) async {
    await _channel.invokeMethod('playAudio', url);
  }

  static Future<void> stopAudio() async {
    await _channel.invokeMethod('stopAudio');
  }

  static Future<void> pauseAudio() async {
    await _channel.invokeMethod('pauseAudio');
  }

  static Future<void> resumeAudio() async {
    await _channel.invokeMethod('resumeAudio');
  }
}
