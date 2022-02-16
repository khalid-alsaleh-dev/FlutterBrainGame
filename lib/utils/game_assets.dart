import 'package:flutter/services.dart';
import 'package:soundpool/soundpool.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

class GameAssets {
  static const alarm = 'assets/images/alarm.svg';
  static const bookFrontFace = 'assets/images/front_face_book.svg';
  static const book = 'assets/images/book.svg';
  static const chair = 'assets/images/chair.svg';
  static const eraser = 'assets/images/eraser.svg';
  static const light = 'assets/images/light.svg';
  static const message = 'assets/images/message.svg';
  static const pencil = 'assets/images/pencil.svg';
  static const ruler = 'assets/images/ruler.svg';
  static const coin = 'assets/images/coin.svg';
  static const studyDesk = 'assets/images/table.svg';
  static const gameOver = 'assets/images/game_over.svg';
  static const victory = 'assets/images/victory.svg';
  static const star = 'assets/images/star.svg';
  static const _turnOnSound = 'assets/sounds/light_turn_on.mp3';
  static const _turnOffSound = 'assets/sounds/light_turn_off.mp3';
  static const _clockTickingSound = 'assets/sounds/clock_ticking.mp3';
  static const _backgroundMusicSound = 'assets/sounds/background_music.mp3';
  static const _gameOverSound = 'assets/sounds/game_over.mp3';
  static const _victorySound = 'assets/sounds/victory.mp3';
  static const _earnCoinsSound = 'assets/sounds/earn_coins.mp3';

  static late final int turnOnSoundId;
  static late final int turnOffSoundId;
  static late final int clockTickingId;
  static late final int gameOverSoundId;
  static late final int victorySoundId;
  static late final int earnCoinsSoundId;

  static late final Soundpool pool;
  static late final AudioPlayer backgroundPlayer;

  
  static Future<void> prereloadAssets() async {
    await _preloadImageAssets();
    await _preloadAudioAssets();
  }

  static Future<void> _preloadAudioAssets() async {
    backgroundPlayer = AudioPlayer();
    pool = Soundpool.fromOptions(
        options: const SoundpoolOptions(
      streamType: StreamType.alarm,
    ));
    await backgroundPlayer.setFilePath(_backgroundMusicSound);
    await backgroundPlayer.setLoopMode(LoopMode.one);
    turnOnSoundId =
        await rootBundle.load(_turnOnSound).then((ByteData soundData) {
      return pool.load(soundData);
    });
    turnOffSoundId =
        await rootBundle.load(_turnOffSound).then((ByteData soundData) {
      return pool.load(soundData);
    });
    clockTickingId =
        await rootBundle.load(_clockTickingSound).then((ByteData soundData) {
      return pool.load(soundData);
    });
    gameOverSoundId =
        await rootBundle.load(_gameOverSound).then((ByteData soundData) {
      return pool.load(soundData);
    });
    victorySoundId =
        await rootBundle.load(_victorySound).then((ByteData soundData) {
      return pool.load(soundData);
    });
    earnCoinsSoundId =
        await rootBundle.load(_earnCoinsSound).then((ByteData soundData) {
      return pool.load(soundData);
    });
  }

  static Future<void> _preloadImageAssets() async {
    List _svgAssets = [
      alarm,
      bookFrontFace,
      book,
      chair,
      eraser,
      light,
      message,
      pencil,
      ruler,
      studyDesk,
      gameOver,
      victory,
      star
    ];

    for (var svg in _svgAssets) {
      await precachePicture(
          ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, svg), null);
    }
  }
}
