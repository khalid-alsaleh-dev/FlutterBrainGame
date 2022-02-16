import 'package:flutter/material.dart';
import 'package:brain_game/classes/driver.dart';
import 'package:brain_game/enums/swap_item_name.dart';
import 'package:brain_game/ui/widgets/book.dart';
import 'package:brain_game/utils/breakpoints.dart';

class BooksContainer extends StatelessWidget {
  const BooksContainer({
    Key? key,
    required this.width,
    required this.stateKeysMap,
  }) : super(key: key);
  final double width;
  final Map<Enum, GlobalKey<State<StatefulWidget>>> stateKeysMap;

  @override
  Widget build(BuildContext context) {
    Driver().setContext = context;
    return Positioned(
      bottom: (width >= Preakpoints.md) ? width * 0.26 : width * 0.33,
      child: SizedBox(
        width: (width >= Preakpoints.md) ? width * 0.4 : width * 0.5,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Book(
                key: stateKeysMap[SwapItemName.firstSwapItem],
                width: width,
                swapItem: SwapItemName.firstSwapItem,
              ),
              Book(
                key: stateKeysMap[SwapItemName.secondSwapItem],
                width: width,
                swapItem: SwapItemName.secondSwapItem,
              ),
              Book(
                key: stateKeysMap[SwapItemName.thirdSwapItem],
                width: width,
                swapItem: SwapItemName.thirdSwapItem,
              ),
            ]),
      ),
    );
  }
}
