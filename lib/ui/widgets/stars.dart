import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_game/classes/driver.dart';
import 'package:brain_game/utils/game_assets.dart';

class Stars extends StatefulWidget {
  const Stars({Key? key}) : super(key: key);
  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> {
  final starsList = List.generate(Driver().getNumberOfStars * 2 + 1, (index) {
    if (index % 2 != 0) {
      return Expanded(
        flex: 2,
        child: SvgPicture.asset(
          GameAssets.star,
        ),
      );
    } else {
      return const Expanded(child: SizedBox(), flex: 1);
    }
  });
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: Driver().getNumberOfStars > 0 ? 2 : 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: starsList,
      ),
    );
  }
}
