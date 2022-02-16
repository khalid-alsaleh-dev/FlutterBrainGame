import 'package:flutter/material.dart';
import 'package:brain_game/enums/game_state.dart';
import 'package:brain_game/controllers/game_state_controller.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:brain_game/utils/game_colors.dart';

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: GameColors.primary,
      child: Center(
          child: Container(
        width: width * 0.17,
        height: width * 0.17,
        constraints: const BoxConstraints(minHeight: 150, minWidth: 150),
        child: ElevatedButton(
          onPressed: () async {
            GameStateController.to.updateState(GameState.play);
            await GameAssets.backgroundPlayer.play();
          },
          child: LayoutBuilder(builder: (context, constraints) {
            double maxWidthOfButton = constraints.maxWidth;
            return SizedBox(
              width: maxWidthOfButton * 0.75,
              height: maxWidthOfButton * 0.3,
              child: const FittedBox(
                child: Text(
                  'Play',
                  style: TextStyle(
                    color: GameColors.grey,
                    fontFamily: 'RubikMonoOne',
                  ),
                ),
              ),
            );
          }),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(const CircleBorder()),
            padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
            elevation: MaterialStateProperty.all<double>(10),
            backgroundColor: MaterialStateProperty.all(
                GameColors.primary), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.pressed)) {
                return GameColors.green;
              }
              // <-- hover color
              else {
                return GameColors.secondary;
              }
            }),
          ),
        ),
      )),
    );
  }
}
// () async{
//                 GameStateController.to.updateState(GameState.play);
//                await GameAssets.backgroundPlayer.play();
                
//               },