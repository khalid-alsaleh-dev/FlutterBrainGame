import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_game/controllers/game_score_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_game/utils/game_assets.dart';

class Score extends StatefulWidget {
  const Score({Key? key, required this.width}) : super(key: key);
  final double width;

  @override
  State<Score> createState() => ScoreState();
}

class ScoreState extends State<Score> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _flipCoinAnimaiton;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    _flipCoinAnimaiton = Tween<double>(begin: 0, end: 50).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void flipCoin() {
    _animationController.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      right: widget.width*0.002,
      width:widget.width*0.15,
      height: widget.width*0.1,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              child: GetBuilder<GameScoreController>(builder: (gameVariableController) {
                return Text(gameVariableController.score.toString(),
                textAlign: TextAlign.center,
                    );
              }),
            ),
          ),
         const Expanded(
            flex: 3,
            child: FittedBox(child: Text('/30' ,  textAlign: TextAlign.end,))),
          const Expanded(
            flex: 1,
            child:  SizedBox()),
          Expanded(
            flex: 4,
            child: AnimatedBuilder(
                animation: _flipCoinAnimaiton,
                builder: (context, _) {
                  return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(2 * pi * _flipCoinAnimaiton.value),
                      child: SvgPicture.asset(GameAssets.coin,
                            // width: 0.035 * widget.width
                          ));
                }),
          ),
        ],
      ),
    );
  }
}
