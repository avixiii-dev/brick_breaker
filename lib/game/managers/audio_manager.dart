import 'package:flame_audio/flame_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioManager {
  static final AudioManager _singleton = AudioManager._internal();

  factory AudioManager() {
    return _singleton;
  }

  AudioManager._internal();

  bool isMute = false;

  initialize() {
    loadAudioToCache();
    _loadMuteStatus();
  }

  loadAudioToCache() async {
    await FlameAudio.audioCache.loadAll([
      'collect_ball.ogg',
      'collect_star.ogg',
      'hit_brick.ogg',
      // 'bg_music.ogg'
    ]);
  }

  play(String type) {
    if (!isMute) {
      if (type == 'hit_brick') {
        FlameAudio.play('hit_brick.ogg');
      } else if (type == 'collect_ball') {
        FlameAudio.play('collect_ball.ogg');
      } else if (type == 'collect_star') {
        FlameAudio.play('collect_star.ogg');
      }
    }
  }

// Play background music
  void playBackgroundMusic() {
    if (!isMute) {
      FlameAudio.bgm
          .play('bg_music.ogg', volume: 0.6); // Adjust volume as needed
    }
  }

  // Stop background music
  void stopBackgroundMusic() {
    FlameAudio.bgm.stop();
  }

  // Toggle sound mute status and save it to shared preferences
  Future<void> toggleSound() async {
    isMute = !isMute;
    await _saveMuteStatus();

    // toggleBgMusic(); // uncomment if bg music need
  }

  // Save mute status to SharedPreferences
  Future<void> _saveMuteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('sound', isMute);
  }

  // Load mute status from SharedPreferences
  Future<void> _loadMuteStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isMute = prefs.getBool('sound') ??
        false; // Default to false if no value is found

    // toggleBgMusic(); // uncomment if bg music need
  }

  toggleBgMusic() {
    if (isMute) {
      stopBackgroundMusic(); // Ensure BGM is stopped if muted
    } else {
      playBackgroundMusic(); // Start BGM if not muted
    }
  }
}
