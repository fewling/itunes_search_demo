import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const size = 48.0;

    final loadingWidgets = [
      LoadingAnimationWidget.threeRotatingDots(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.staggeredDotsWave(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.fourRotatingDots(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.fallingDot(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.prograssiveDots(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.threeArchedCircle(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.beat(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.horizontalRotatingDots(
        color: colorScheme.primary,
        size: size,
      ),
      LoadingAnimationWidget.stretchedDots(
        color: colorScheme.primary,
        size: size,
      ),
    ];
    loadingWidgets.shuffle();
    return loadingWidgets.first;
  }
}
