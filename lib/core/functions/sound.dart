import 'package:audioplayers/audioplayers.dart';

class AudioPlayerWrapped {
  final AudioPlayer player;
  final String directory;

  AudioPlayerWrapped({
    required this.player,
    required this.directory,
  });
}

class Sound {
  static List<AudioPlayerWrapped> players = [];

  static Future<AudioPlayer> playSound(String directory) async {
    AudioPlayer? player;
    bool foundPlayer = false;
    for (AudioPlayerWrapped playerWrapped in players) {
      if (playerWrapped.directory == directory) {
        player = playerWrapped.player;
        foundPlayer = true;
        break;
      }
    }

    player ??= AudioPlayer();

    await player.stop();
    await player.play(DeviceFileSource(directory));

    if (!foundPlayer) {
      players.add(
        AudioPlayerWrapped(
          player: player,
          directory: directory,
        ),
      );
    }

    return player;
  }
}
