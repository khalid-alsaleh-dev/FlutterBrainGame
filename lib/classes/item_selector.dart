import 'dart:math';
import 'package:brain_game/enums/event.dart';
import 'package:brain_game/enums/swap_item_name.dart';

class ItemSelector {
  ///A function used to select an item to hold the message randomly
  static SwapItemName select() {
    int randomValue =
        Random(DateTime.now().millisecondsSinceEpoch).nextInt(105);
    if (randomValue <= 35) {
      return SwapItemName.firstSwapItem;
    } else if (35 < randomValue && randomValue <= 70) {
      return SwapItemName.secondSwapItem;
    } else {
      return SwapItemName.thirdSwapItem;
    }
  }

  /// A function used to return the new correct item(which includes the message) after swap if it was one of the event swap items
  static SwapItemName swapSelectedItem(
      Event event, SwapItemName selectedItem) {
    List<String> eventItemsAsStringList = event.name.split("And");
    eventItemsAsStringList =
        eventItemsAsStringList.map((e) => e.toLowerCase()).toList();
    String selectedItemAsString =
        selectedItem.name.replaceFirst(RegExp(r'SwapItem'), '').toLowerCase();
    String newSelectedItemAsString = '';
    bool selectedItemIsRelatedToEvent = false;
    if (eventItemsAsStringList.contains(selectedItemAsString)) {
      for (var element in eventItemsAsStringList) {
        if (element != selectedItemAsString) {
          newSelectedItemAsString = element;
          selectedItemIsRelatedToEvent = true;
          break;
        }
      }
    }
    if (selectedItemIsRelatedToEvent) {
      for (SwapItemName swapItem in SwapItemName.values) {
        if (newSelectedItemAsString ==
            swapItem.name.replaceFirst(RegExp(r'SwapItem'), '')) {
          return swapItem;
        }
      }
    }
    return selectedItem;
  }
}
