import 'package:flutter/material.dart';
import 'package:brain_game/classes/driver.dart';
import 'package:brain_game/classes/item_selector.dart';
import 'package:brain_game/classes/swap_items_box.dart';
import 'package:brain_game/enums/game_state.dart';
import 'package:brain_game/enums/swap_item_name.dart';
import 'package:brain_game/enums/widget_name.dart';
import 'package:brain_game/controllers/game_state_controller.dart';
import 'package:brain_game/controllers/game_variables_controller.dart';
import 'package:brain_game/ui/widgets/alram_clock.dart';
import 'package:brain_game/ui/widgets/book.dart';
import 'package:brain_game/ui/widgets/light.dart';
import 'package:brain_game/ui/widgets/play.dart';
import 'package:brain_game/ui/widgets/score.dart';
import 'package:brain_game/ui/widgets/start.dart';
import 'package:get/get.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:brain_game/utils/game_colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final Map<Enum, GlobalKey<State<StatefulWidget>>> _stateKeysMap;

  @override
  void initState() {
    super.initState();
    Get.put<GameVariableController>(GameVariableController());
    Get.put<GameStateController>(GameStateController());
    _stateKeysMap = {
      SwapItemName.firstSwapItem: GlobalKey<BookState>(),
      SwapItemName.secondSwapItem: GlobalKey<BookState>(),
      SwapItemName.thirdSwapItem: GlobalKey<BookState>(),
      WidgetName.score: GlobalKey<ScoreState>(),
      WidgetName.traingleLight: GlobalKey<TraingleLightState>(),
      WidgetName.alarmClock: GlobalKey<AlarmClockState>(),
    };
    Driver().setStateKeysMap = _stateKeysMap;
    SwapItemsBox().setSelectedSwapItem = ItemSelector.select();
  }
  @override
  void dispose() {
     GameAssets.backgroundPlayer.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double widthOfScreen = size.width;
    double heightOfScreen = size.height;
    bool isPortrait = heightOfScreen >= widthOfScreen;
    double widthOfGame = (isPortrait) ? heightOfScreen : widthOfScreen;
    double heightOfGame = (isPortrait) ? widthOfScreen : heightOfScreen;
    return RotatedBox(
      quarterTurns: (isPortrait) ? 1 : 0,
      child: Scaffold(
        backgroundColor:GameColors.primary,
        body: GetBuilder<GameStateController>(builder: (gameStateController) {
            return SizedBox(
          width: widthOfGame,
          height: heightOfGame,
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            switchInCurve: Curves.easeInOut,
            transitionBuilder:(child,animation){
              return ScaleTransition(scale: animation, child: child);
            } ,
            child: (gameStateController.state == GameState.start)
                ? const Start()
                : Play(
                    widthOfScreen: widthOfGame,
                    heightOfScreen: heightOfGame,
                    stateKeysMap: _stateKeysMap),
          ));
          }),
      ),
    );
  }
}


