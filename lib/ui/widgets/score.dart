import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_game/controllers/game_variables_controller.dart';
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
      top: 20,
      right: 50,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<GameVariableController>(builder: (gameVariableController) {
            return Text(gameVariableController.score.toString(),
                style: const TextStyle(fontSize: 30));
          }),
          const Text('/30', style: TextStyle(fontSize: 30)),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              flipCoin();
            },
            child: AnimatedBuilder(
                animation: _flipCoinAnimaiton,
                builder: (context, _) {
                  return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateY(2 * pi * _flipCoinAnimaiton.value),
                      child: SvgPicture.asset(GameAssets.coin,
                          width: 0.035 * widget.width));
                }),
          ),
        ],
      ),
    );
  }
}
