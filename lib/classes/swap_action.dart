import 'dart:math';
import 'package:brain_game/models/swap_item.dart';
import 'package:brain_game/enums/event.dart';
import 'package:flutter/material.dart';
import 'package:brain_game/utils/breakpoints.dart';

class SwapAction {
  final SwapItem prefixItem;
  final SwapItem suffixItem;
  SwapAction({
    required this.prefixItem,
    required this.suffixItem,
  });

/// A factory to create a swap action object includes prefix and suffix items with their horizontal and vertical spaces
  factory SwapAction.createSwapActionByEvent(
      Event event, BuildContext context) {
    SwapItem prefix, suffix;
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    double logicalWidth = width>=height?width:height;
    double logicalHeight =  width<height?width:height;
    double verticalAnimationValue = logicalHeight / 8;
    double sign = Random().nextBool() ? 1 : -1;
    if (event == Event.firstAndSecond) {  
      double horizontalAnimationValue =(logicalWidth>=Preakpoints.md)? logicalWidth / 8.2:logicalWidth /6.6;
      prefix = SwapItem(
          horizontalSpace: horizontalAnimationValue,  
          verticalSpace: sign * verticalAnimationValue);
      suffix = SwapItem(
          horizontalSpace: -1 * horizontalAnimationValue,
          verticalSpace: -1 * sign * verticalAnimationValue);
    } else if (event == Event.secondAndThird) {
      double horizontalAnimationValue =(logicalWidth>=Preakpoints.md)? logicalWidth / 8.2:logicalWidth / 6.6;
      prefix = SwapItem(
          horizontalSpace: horizontalAnimationValue,
          verticalSpace: sign * verticalAnimationValue);
      suffix = SwapItem(
          horizontalSpace: -1 * horizontalAnimationValue,
          verticalSpace: -1 * sign * verticalAnimationValue);
    } else {
       double horizontalAnimationValue =(logicalWidth>=Preakpoints.md)? logicalWidth / 4.1:logicalWidth / 3.2;
      prefix = SwapItem(
          horizontalSpace: horizontalAnimationValue,
          verticalSpace: sign * verticalAnimationValue);
      suffix = SwapItem(
          horizontalSpace: -1 * horizontalAnimationValue,
          verticalSpace: -1 * sign * verticalAnimationValue);
    }
    return SwapAction(prefixItem: prefix, suffixItem: suffix);
  }
}
