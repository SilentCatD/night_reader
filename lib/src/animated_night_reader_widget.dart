import 'package:flutter/material.dart';

import 'night_reader_widget.dart';

/// Animated version of [NightReader]. Will automatically lerp between
/// [AnimatedNightReader.value]s when [State.setState] with a different value.
///
/// The animation of all other properties is also supported. To see document
/// of each property, see [NightReader] and [ImplicitlyAnimatedWidget].
///
/// This widget would require [Curve] and [Duration] for the animation.
class AnimatedNightReader extends ImplicitlyAnimatedWidget {
  const AnimatedNightReader({
    Key? key,
    required Duration duration,
    Curve curve = Curves.easeIn,
    VoidCallback? onEnd,
    required this.value,
    this.tint = Colors.yellow,
    this.minDarkenOpacity = 0,
    this.maxDarkenOpacity = 0.3,
    this.minTintOpacity = 0,
    this.maxTintOpacity = 0.5,
    required this.child,
  })  : assert(value >= 0 && value <= 1),
        assert(minDarkenOpacity >= 0 && minDarkenOpacity <= maxDarkenOpacity),
        assert(maxDarkenOpacity >= minDarkenOpacity && maxDarkenOpacity <= 1),
        assert(minTintOpacity >= 0 && minTintOpacity <= maxTintOpacity),
        assert(maxTintOpacity >= minTintOpacity && maxTintOpacity <= 1),
        super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
        );
  final double value;
  final Color tint;
  final double minDarkenOpacity;
  final double maxDarkenOpacity;
  final double minTintOpacity;
  final double maxTintOpacity;
  final Widget child;

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedNightReaderState();
  }
}

class _AnimatedNightReaderState
    extends ImplicitlyAnimatedWidgetState<AnimatedNightReader> {
  Tween<double>? _valueTween;
  ColorTween? _tintTween;
  Tween<double>? _minDarkenOpacityTween;
  Tween<double>? _maxDarkenOpacityTween;
  Tween<double>? _minTintOpacityTween;
  Tween<double>? _maxTintOpacityTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _valueTween = visitor(
            _valueTween, widget.value, (value) => Tween<double>(begin: value))
        as Tween<double>?;
    _tintTween =
        visitor(_tintTween, widget.tint, (value) => ColorTween(begin: value))
            as ColorTween?;
    _minDarkenOpacityTween = visitor(
        _minDarkenOpacityTween,
        widget.minDarkenOpacity,
        (value) => Tween<double>(begin: value)) as Tween<double>?;
    _maxDarkenOpacityTween = visitor(
        _maxDarkenOpacityTween,
        widget.maxDarkenOpacity,
        (value) => Tween<double>(begin: value)) as Tween<double>?;
    _minTintOpacityTween = visitor(_minTintOpacityTween, widget.minTintOpacity,
        (value) => Tween<double>(begin: value)) as Tween<double>?;
    _maxTintOpacityTween = visitor(_maxTintOpacityTween, widget.maxTintOpacity,
        (value) => Tween<double>(begin: value)) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return NightReader(
          value: _valueTween?.evaluate(animation) ?? widget.value,
          tint: _tintTween?.evaluate(animation) ?? widget.tint,
          minDarkenOpacity: _minDarkenOpacityTween?.evaluate(animation) ??
              widget.minDarkenOpacity,
          maxDarkenOpacity: _maxDarkenOpacityTween?.evaluate(animation) ??
              widget.maxDarkenOpacity,
          minTintOpacity: _minTintOpacityTween?.evaluate(animation) ??
              widget.minTintOpacity,
          maxTintOpacity: _maxTintOpacityTween?.evaluate(animation) ??
              widget.maxTintOpacity,
          child: child!,
        );
      },
      child: widget.child,
    );
  }
}
