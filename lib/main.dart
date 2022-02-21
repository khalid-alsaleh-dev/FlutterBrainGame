import 'package:brain_game/utils/game_colors.dart';
import 'package:flutter/material.dart';
import 'package:brain_game/ui/screens/home.dart';
import 'package:brain_game/utils/game_assets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GameAssets.prereloadAssets();
  runApp( MaterialApp(
    theme: ThemeData(
      primaryColor: GameColors.green,
    ),
    title: 'BrainGame',
    home: const Home(),
    debugShowCheckedModeBanner: false,
  ));
}
