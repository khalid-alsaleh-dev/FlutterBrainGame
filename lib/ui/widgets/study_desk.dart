import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:brain_game/utils/breakpoints.dart';


class StudyDesk extends StatelessWidget {
  const StudyDesk({Key? key, required this.width}) : super(key: key);
  final double width;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      child: SvgPicture.asset(
        GameAssets.studyDesk, 
        clipBehavior: Clip.none,
         width: (width >= Preakpoints.md)
          ? width - width / 4
          : width - width * 0.1,
      ),
    );
  }
}
