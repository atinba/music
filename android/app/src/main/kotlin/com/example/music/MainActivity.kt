package com.example.music

import android.os.Bundle
import androidx.annotation.NonNull
import androidx.media3.common.MediaItem
import androidx.media3.exoplayer.ExoPlayer
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example/media3"
    private var exoPlayer: ExoPlayer? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "playAudio" -> {
                    val url = call.arguments as String
                    playAudio(url)
                    result.success(null)
                }
                "stopAudio" -> {
                    stopAudio()
                    result.success(null)
                }
                "pauseAudio" -> {
                    pauseAudio()
                    result.success(null)
                }
                "resumeAudio" -> {
                    resumeAudio()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun playAudio(url: String) {
        if (exoPlayer == null) {
            exoPlayer = ExoPlayer.Builder(this).build()
        }
        val mediaItem = MediaItem.fromUri(url)
        exoPlayer?.setMediaItem(mediaItem)
        exoPlayer?.prepare()
        exoPlayer?.play()
    }

    private fun stopAudio() {
        exoPlayer?.stop()
        exoPlayer?.release()
        exoPlayer = null
    }

    private fun pauseAudio() {
        exoPlayer?.pause()
    }

    private fun resumeAudio() {
        exoPlayer?.play()
    }
}
