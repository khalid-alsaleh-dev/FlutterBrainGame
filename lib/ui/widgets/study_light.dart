import 'package:flutter/material.dart';
import 'package:brain_game/ui/widgets/light.dart';
import 'package:brain_game/utils/breakpoints.dart';
import 'package:brain_game/utils/game_assets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StudyLight extends StatelessWidget {
  const StudyLight(
      {Key? key, required this.width, required this.traingleStateKey})
      : super(key: key);
  final double width;
  final GlobalKey<State<StatefulWidget>>? traingleStateKey;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: (width >= Preakpoints.md) ? 0.26 * width : 0.35 * width,
      left: (width >= Preakpoints.md) ? 0.126 * width : 0.056 * width,
      child: InkWell(
        onTap: () async {
          (traingleStateKey?.currentState as TraingleLightState).switchLight();
        },
        child: SvgPicture.asset(
          GameAssets.light,
          width: (width >= Preakpoints.md) ? 0.17 * width : 0.2 * width,
        ),
      ),
    );
  }
}
