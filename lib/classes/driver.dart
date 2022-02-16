import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_game/classes/swap_action.dart';
import 'package:brain_game/enums/event.dart';
import 'package:brain_game/constants/game_constants.dart';
import 'package:brain_game/enums/swap_item_name.dart';
import 'package:brain_game/classes/event_generator.dart';
import 'package:brain_game/classes/item_selector.dart';
import 'package:brain_game/enums/widget_name.dart';
import 'package:brain_game/classes/swap_items_box.dart';
import 'package:brain_game/ui/widgets/alram_clock.dart';
import 'package:brain_game/ui/widgets/book.dart';
import 'package:brain_game/ui/widgets/score.dart';
import 'package:brain_game/ui/widgets/score_dialog.dart';
import 'package:brain_game/utils/game_assets.dart';
import '../controllers/game_variables_controller.dart';

// singleton class
class Driver {
  static final Driver _instance = Driver._internal();
  factory Driver() => _instance;

  Driver._internal() {
    _numberOfPlayedLevels = 0;
    _numberOfPlayedRoundsBerLevel = 0;
    _timeInMilliseconds = GameCosntants.startTimeInMilliseconds;
  }

  late final Map<Enum, GlobalKey<State<StatefulWidget>>> _stateKeysMap;
  late BuildContext _context;
  late int _numberOfPlayedLevels;
  late int _numberOfPlayedRoundsBerLevel;
  late int _timeInMilliseconds;
  late int _streamId;
  Future drive(bool isFirstSelect) async {
    if (_numberOfPlayedLevels < GameCosntants.numberOfLevels) {
      if (_numberOfPlayedRoundsBerLevel ==
          GameCosntants.numberOfRoundsBerLevel) {
        //  increment the numberOfPlayedLevels variable and reset the numberOfPlayedRoundsBerLevel variable
        _numberOfPlayedLevels++;
        _numberOfPlayedRoundsBerLevel = 0;
        //  decrement the duration of swap
        _decrementDurationOfSwapAnimation();
      }
      for (int i = 0; i < randomNumberOfSwaps; i++) {
        // generate a swap event
        Event event = EventGenerator.generate();
        // generate an action
        SwapAction action = SwapAction.createSwapActionByEvent(event, _context);
        // send the action swap items to the swap items box and run the swap animation
        await _sendActionValuesToBoxAndRunTheAnimation(event, action);
      }
      //  increment the numberOfPlayedRoundsBerLevel variable
      if (!isFirstSelect) {
        _numberOfPlayedRoundsBerLevel++;
      }
    }else{
       // game finished,the player won😍
    showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (context) {
            return const ScoreDialog(
              isVectory: true,
            );
          });
    }
   
  }

  void select(SwapItemName label, bool isFirstSelect) async {
    if (SwapItemsBox().getSelectedSwapItem == label) {
      if (!isFirstSelect) {
        //  the selected item is true => increment the score🎈
        GameVariableController.to.incrementScore();
        // play the flip coin animation
        (_stateKeysMap[WidgetName.scoure]?.currentState as ScoreState)
            .flipCoin();
        // play the earn coin sound effect
        GameAssets.pool.play(GameAssets.earnCoinsSoundId);
      }
      // run the drive function
      drive(isFirstSelect);
    } else {
      //  the selected item is wrong😥
      // stop the background music
      await GameAssets.backgroundPlayer.stop();
      // stop the alarm clock tic
      (_stateKeysMap[WidgetName.alarmClock]?.currentState as AlarmClockState)
          .cancelClock();

      int score = GameVariableController.to.score;
      late bool isVectory;
      if (score >= 15) {
        isVectory = true;
      } else {
        isVectory = false;
      }
      // play the correct sound effect (vectory or game over) depending on the score
      if (isVectory) {
        _streamId = await GameAssets.pool.play(GameAssets.victorySoundId);
      } else {
        _streamId = await GameAssets.pool.play(GameAssets.gameOverSoundId);
      }
      // show the score dialog
      showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (context) {
            return ScoreDialog(
              isVectory: isVectory,
            );
          });
    }
  }

  void restart() async {
    _cleanGameVariables();
    // select a random book to restart the game
    SwapItemsBox().setSelectedSwapItem = ItemSelector.select();
    // open the book that contains the message and then reset the duration of animation 
    _stateKeysMap.forEach((key, value) {
      if (((key.name.length) > 8) &&
          key.name.substring((key.name.length) - 8) == 'SwapItem') {
        (value.currentState as BookState).runFirstCheckAnimation();
        (value.currentState as BookState).setDurationOfSwapAnimation(
            Duration(milliseconds: _timeInMilliseconds));
      }
    });
    // start the clock again
    (_stateKeysMap[WidgetName.alarmClock]?.currentState as AlarmClockState)
        .startClock();
       //  if the user clicked on the restart button before the vectory or game over music finished stop it
    await GameAssets.pool.stop(_streamId);
    // restart the background music again
    await GameAssets.backgroundPlayer.seekToNext();
    await GameAssets.backgroundPlayer.play();
  }

  set setContext(context) => _context = context;
  set setStateKeysMap(map) => _stateKeysMap = map;

  void _cleanGameVariables() {
    GameVariableController.to.cleanScore();
    _numberOfPlayedLevels = 0;
    _numberOfPlayedRoundsBerLevel = 0;
    _timeInMilliseconds = GameCosntants.startTimeInMilliseconds;
  }

  void _decrementDurationOfSwapAnimation() {
    _timeInMilliseconds -= GameCosntants.timeToDecrementInMilliseconds;
    _stateKeysMap.forEach((key, value) {
      if (((key.name.length) > 8) &&
          key.name.substring((key.name.length) - 8) == 'SwapItem') {
        (value.currentState as BookState).setDurationOfSwapAnimation(
            Duration(milliseconds: _timeInMilliseconds));
      }
    });
  }

  String get getRank {
    int score = GameVariableController.to.score;
    if (score < 5) {
      return GameCosntants.ranks[0];
    } else if (score >= 5 && score < 10) {
      return GameCosntants.ranks[1];
    } else if (score >= 10 && score < 15) {
      return GameCosntants.ranks[2];
    } else if (score >= 15 && score < 20) {
      return GameCosntants.ranks[3];
    } else if (score >= 20 && score < 25) {
      return GameCosntants.ranks[4];
    } else {
      return GameCosntants.ranks[5];
    }
  }

  int get getNumberOfStars {
    int score = GameVariableController.to.score;
    if (score < 10) {
      return 0;
    }
    if (score >= 10 && score < 15) {
      return 1;
    } else if (score >= 15 && score < 20) {
      return 2;
    } else if (score >= 20 && score < 25) {
      return 3;
    } else {
      return 4;
    }
  }

  int get randomNumberOfSwaps =>
      GameCosntants.minNumberOfSwapsBerLevel[
          _numberOfPlayedRoundsBerLevel - 1 == -1
              ? 0
              : _numberOfPlayedRoundsBerLevel - 1] +
      Random(DateTime.now().millisecondsSinceEpoch).nextInt(GameCosntants
                  .maxNumberOfSwapsBerLevelArray[
              _numberOfPlayedRoundsBerLevel - 1 == -1
                  ? 0
                  : _numberOfPlayedRoundsBerLevel - 1] -
          GameCosntants.minNumberOfSwapsBerLevel[
              _numberOfPlayedRoundsBerLevel - 1 == -1
                  ? 0
                  : _numberOfPlayedRoundsBerLevel - 1]);

  Future<void> _sendActionValuesToBoxAndRunTheAnimation(
      Event event, SwapAction action) async {
    if (event == Event.firstAndSecond) {
      SwapItemsBox().setSwapItem(
          swapItemLabel: SwapItemName.firstSwapItem,
          swapItem: action.prefixItem);
      SwapItemsBox().setSwapItem(
          swapItemLabel: SwapItemName.secondSwapItem,
          swapItem: action.suffixItem);
      SwapItemsBox().setSelectedSwapItem = ItemSelector.swapSelectedItem(
          event, SwapItemsBox().getSelectedSwapItem);
      await _runTheSwapAnimation(
          SwapItemName.firstSwapItem, SwapItemName.secondSwapItem);
    } else if (event == Event.secondAndThird) {
      SwapItemsBox().setSwapItem(
          swapItemLabel: SwapItemName.secondSwapItem,
          swapItem: action.prefixItem);
      SwapItemsBox().setSwapItem(
          swapItemLabel: SwapItemName.thirdSwapItem,
          swapItem: action.suffixItem);
      SwapItemsBox().setSelectedSwapItem = ItemSelector.swapSelectedItem(
          event, SwapItemsBox().getSelectedSwapItem);
      await _runTheSwapAnimation(
          SwapItemName.secondSwapItem, SwapItemName.thirdSwapItem);
    } else {
      SwapItemsBox().setSwapItem(
          swapItemLabel: SwapItemName.firstSwapItem,
          swapItem: action.prefixItem);
      SwapItemsBox().setSwapItem(
          swapItemLabel: SwapItemName.thirdSwapItem,
          swapItem: action.suffixItem);
      SwapItemsBox().setSelectedSwapItem = ItemSelector.swapSelectedItem(
          event, SwapItemsBox().getSelectedSwapItem);
      await _runTheSwapAnimation(
          SwapItemName.firstSwapItem, SwapItemName.thirdSwapItem);
    }
  }
// this function tells us that whether we can click on the book to choose it
  bool checkSelectEnable() {
    return ((!(_stateKeysMap[SwapItemName.firstSwapItem]?.currentState
                as BookState)
            .isAnimating) &&
        (!(_stateKeysMap[SwapItemName.secondSwapItem]?.currentState
                as BookState)
            .isAnimating) &&
        !(_stateKeysMap[SwapItemName.thirdSwapItem]?.currentState as BookState)
            .isAnimating);
  }

  Future<void> _runTheSwapAnimation(
      SwapItemName firstItem, SwapItemName secondItem) async {
    // await only the second to make them work simultaneously
    (_stateKeysMap[firstItem]?.currentState as BookState).runForwardAnimation();
    await (_stateKeysMap[secondItem]?.currentState as BookState)
        .runForwardAnimation();
  }
}
