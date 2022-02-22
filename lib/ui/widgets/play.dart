import 'package:flutter/material.dart';
import 'package:brain_game/enums/widget_name.dart';
import 'package:brain_game/ui/widgets/alram_clock.dart';
import 'package:brain_game/ui/widgets/books_container.dart';
import 'package:brain_game/ui/widgets/chair.dart';
import 'package:brain_game/ui/widgets/light.dart';
import 'package:brain_game/ui/widgets/score.dart';
import 'package:brain_game/ui/widgets/stationery.dart';
import 'package:brain_game/ui/widgets/study_desk.dart';
import 'package:brain_game/ui/widgets/study_light.dart';
import 'package:brain_game/utils/game_colors.dart';

class Play extends StatelessWidget {
  const Play({
    Key? key,
    required this.widthOfScreen,
    required this.heightOfScreen,
    required Map<Enum, GlobalKey<State<StatefulWidget>>> stateKeysMap,
  })  : _stateKeysMap = stateKeysMap,
        super(key: key);

  final double widthOfScreen;
  final double heightOfScreen;
  final Map<Enum, GlobalKey<State<StatefulWidget>>> _stateKeysMap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Positioned.fill(
          child: Column(
            children: [
              Expanded(
                child: Container(color: GameColors.primary),
                flex: 3,
              ),
              Expanded(
                child: Container(color: GameColors.secondary),
                flex: 2,
              )
            ],
          ),
        ),
        SizedBox(
          width: widthOfScreen,
          height: heightOfScreen,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              StudyDesk(width: widthOfScreen),
              Stationery(
                width: widthOfScreen,
              ),
              BooksContainer(
                width: widthOfScreen,
                stateKeysMap: _stateKeysMap,
              ),
              Chair(width: widthOfScreen),
              TraingleLight(
                width: widthOfScreen,
                key: _stateKeysMap[WidgetName.traingleLight],
              ),
              StudyLight(
                width: widthOfScreen,
                traingleStateKey: _stateKeysMap[WidgetName.traingleLight],
              ),
              
              AlarmClock(
                width: widthOfScreen,
                key: _stateKeysMap[WidgetName.alarmClock],
              ),
              Score(
                width: widthOfScreen,
                key: _stateKeysMap[WidgetName.score],
              )
            ],
          ),
        )
      ],
    );
  }
}
