import 'package:flutter/material.dart';
import 'package:brain_game/ui/screens/home.dart';
import 'package:brain_game/utils/game_assets.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await GameAssets.prereloadAssets();
  runApp(
    const MaterialApp(
    title: 'BrainGame',
    home: Home(),
    debugShowCheckedModeBanner: false,
  )
  );
}
