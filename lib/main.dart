import 'package:brain_game/utils/game_colors.dart';
import 'package:flutter/material.dart';
import 'package:brain_game/ui/screens/home.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:flutter/services.dart';

void main()async {
   SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor:GameColors.primary, 
    statusBarColor: GameColors.primary, 
  ));
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
