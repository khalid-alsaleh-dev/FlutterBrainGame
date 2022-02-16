import 'dart:math';
import 'package:flutter/material.dart';
import 'package:brain_game/classes/driver.dart';
import 'package:brain_game/enums/swap_item_name.dart';
import 'package:brain_game/classes/swap_items_box.dart';
import 'package:brain_game/utils/breakpoints.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:brain_game/utils/game_assets.dart';

class Book extends StatefulWidget {
  const Book({Key? key, required this.width, required this.swapItem})
      : super(key: key);

  final double width;
  final SwapItemName swapItem;
  @override
  State<Book> createState() => BookState();
}

class BookState extends State<Book> with TickerProviderStateMixin {
  late final AnimationController _swapController;
  late final AnimationController _flipBookController;
  late final Animation _horizontalAnimation;
  late final Animation _verticalAnimation;
  late final Animation _flipBookAnimation;
  @override
  void initState() {
    super.initState();
    _swapController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _flipBookController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1300));
    _horizontalAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 0.0), weight: 0.33),
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0), weight: 0.33),
      TweenSequenceItem(tween: Tween(begin: 100.0, end: 100.0), weight: 0.33),
    ]).animate(_swapController);
    _verticalAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 100.0), weight: 0.33),
      TweenSequenceItem(tween: Tween(begin: 100.0, end: 100.0), weight: 0.33),
      TweenSequenceItem(tween: Tween(begin: 100.0, end: 0.0), weight: 0.33),
    ]).animate(_swapController);
    _flipBookAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 0.20),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.0), weight: 0.60),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 0.20),
    ]).animate(_flipBookController);
    _swapController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _swapController.reset();
      }
    });
    _flipBookController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipBookController.reset();
      }
    });
    // show the selected item to the user (only the first time)
    runFirstCheckAnimation();
  }

  @override
  void dispose() {
    _swapController.dispose();
    _flipBookController.dispose();
    super.dispose();
  }

  Future<void> runForwardAnimation() async {
    if (mounted && _swapController.status == AnimationStatus.dismissed) {
      await _swapController.forward();
    }
  }

  bool get isAnimating =>
      _swapController.isAnimating || _flipBookController.isAnimating;

  Future<void> _runFirstCheckAnimation() async {
    if (_flipBookController.status == AnimationStatus.dismissed) {
      await Future.delayed(const Duration(seconds: 3));
      _flipBookController.duration = const Duration(seconds: 3);
      await _flipBookController.forward();
      _flipBookController.duration = const Duration(milliseconds: 1300);
    }
    Driver().select(widget.swapItem, true);
  }

  void runFirstCheckAnimation() {
    if (widget.swapItem == SwapItemsBox().getSelectedSwapItem) {
      // the reset function call is a hack to recheck the new random selected item to show the message (in restart case)
      _swapController.reset();
      _runFirstCheckAnimation();
    }
  }

  void setDurationOfSwapAnimation(Duration duration) {
    _swapController.duration = duration;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (_flipBookController.status == AnimationStatus.dismissed &&
            Driver().checkSelectEnable()) {
          await _flipBookController.forward();
          Driver().select(widget.swapItem, false);
        }
      },
      child: AnimatedBuilder(
          animation: _horizontalAnimation,
          builder: (context, _) {
            return AnimatedBuilder(
                animation: _verticalAnimation,
                builder: (context, _) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..translate(
                          0.0,
                          SwapItemsBox().getSwapItemVerticalSpace(
                                  swapItemLabel: widget.swapItem) *
                              _verticalAnimation.value /
                              100,
                          0.0)
                      ..translate(
                          SwapItemsBox().getSwapItemHorizontalSpace(
                                  swapItemLabel: widget.swapItem) *
                              _horizontalAnimation.value /
                              100,
                          0.0,
                          0.0),
                    child: Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        Transform(
                          alignment: Alignment.centerLeft,
                          transform: Matrix4.identity()..rotateZ(-pi * 0.01),
                          child: SvgPicture.asset(
                            GameAssets.book,
                            width: (widget.width >= Preakpoints.md)
                                ? 0.08 * widget.width
                                : 0.1 * widget.width,
                          ),
                        ),
                        Visibility(
                          child: Positioned.fill(
                            bottom: 0.02 * widget.width,
                            right: 0.01 * widget.width,
                            child: SvgPicture.asset(
                              GameAssets.message,
                            ),
                          ),
                          visible: widget.swapItem ==
                              SwapItemsBox().getSelectedSwapItem,
                        ),
                        AnimatedBuilder(
                          builder: (context, _) {
                            return Positioned(
                              left: 0,
                              child: Transform(
                                alignment: Alignment.centerLeft,
                                transform: Matrix4.identity()
                                  ..rotateZ(-pi * 0.01)
                                  ..rotateY(pi * _flipBookAnimation.value),
                                child: SvgPicture.asset(
                                  GameAssets.bookFrontFace,
                                  width: (widget.width >= Preakpoints.md)
                                      ? 0.08 * widget.width
                                      : 0.1 * widget.width,
                                ),
                              ),
                            );
                          },
                          animation: _flipBookAnimation,
                        ),
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
