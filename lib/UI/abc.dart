import 'dart:async';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class FingerPrintPlayerOnesss extends StatefulWidget {
  @override
  _FingerPrintPlayerOnesssState createState() =>
      _FingerPrintPlayerOnesssState();
}

class _FingerPrintPlayerOnesssState extends State<FingerPrintPlayerOnesss> {
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool isAudioPlaying = false;
  Timer? audioStopTimer;

  void startAudio() {
    // Load and play the audio
    assetsAudioPlayer.open(Audio("assets/images/musics.mp3"));
    assetsAudioPlayer.play();
    setState(() {
      isAudioPlaying = true;
    });

    // Schedule a timer to stop the audio after 4 seconds
    audioStopTimer = Timer(Duration(seconds: 4), () {
      stopAudio();
    });
  }

  void stopAudio() {
    // Stop the audio
    assetsAudioPlayer.stop();
    setState(() {
      isAudioPlaying = false;
    });

    // Cancel the audio stop timer if it's active
    if (audioStopTimer != null && audioStopTimer!.isActive) {
      audioStopTimer!.cancel();
    }
  }

  @override
  void dispose() {
    assetsAudioPlayer.dispose(); // Dispose of the audio player
    audioStopTimer?.cancel(); // Cancel the audio stop timer
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FingerPrintPlayerOne'),
      ),
      body: Center(
        child: GestureDetector(
          onTapDown: (_) {
            // Stop audio and vibration when tapped down
            stopAudio();
          },
          onTapUp: (_) {
            // Start audio and vibration when released
            startAudio();
          },
          onTapCancel: () {
            // Stop audio and vibration when the gesture is canceled
            stopAudio();
          },
          child: Container(
            width: 200,
            height: 200,
            color: Colors.blue,
            child: Center(
              child: Text(
                isAudioPlaying ? 'Audio Playing' : 'Tap to Play Audio',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
