import 'package:brain_game/classes/item_selector.dart';
import 'package:brain_game/models/swap_item.dart';
import 'package:brain_game/enums/swap_item_name.dart';

/// singleton class (box) that contains the state of the books with some functions to manage them
class SwapItemsBox {
  static final SwapItemsBox _instance = SwapItemsBox._internal();
  factory SwapItemsBox() => _instance;

  SwapItemsBox._internal() {
    _swapItemsMap = {
      SwapItemName.firstSwapItem:
          SwapItem(horizontalSpace: 0.0, verticalSpace: 0.0),
      SwapItemName.secondSwapItem:
          SwapItem(horizontalSpace: 0.0, verticalSpace: 0.0),
      SwapItemName.thirdSwapItem:
          SwapItem(horizontalSpace: 0.0, verticalSpace: 0.0)
    };
    _selectedSwapItem = ItemSelector.select();
  }

  late final Map<SwapItemName, SwapItem?> _swapItemsMap;
  late SwapItemName _selectedSwapItem;

  setSwapItemHorizontalSpace(
          {required SwapItemName swapItemLabel,
          required double horizontalSpace}) =>
      _swapItemsMap[swapItemLabel] = _swapItemsMap[swapItemLabel]
          ?.copyWith(horizontalSpace: horizontalSpace);
  setSwapItemVerticalSpace(
          {required SwapItemName swapItemLabel,
          required double verticalSpace}) =>
      _swapItemsMap[swapItemLabel] =
          _swapItemsMap[swapItemLabel]?.copyWith(verticalSpace: verticalSpace);

  double getSwapItemHorizontalSpace({required SwapItemName? swapItemLabel}) =>
      _swapItemsMap[swapItemLabel]?.horizontalSpace ?? 0;
  double getSwapItemVerticalSpace({required SwapItemName? swapItemLabel}) =>
      _swapItemsMap[swapItemLabel]?.verticalSpace ?? 0;
  setSwapItem(
      {required SwapItemName swapItemLabel, required SwapItem swapItem}) {
    _swapItemsMap[swapItemLabel] = swapItem;
  }

  set setSelectedSwapItem(SwapItemName selectedSwapItem) =>
      _selectedSwapItem = selectedSwapItem;
  get getSelectedSwapItem => _selectedSwapItem;
}
