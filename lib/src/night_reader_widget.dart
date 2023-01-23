import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:night_reader/night_reader.dart';


/// Widget that drawing [NightReader.tint] with [BlendMode.darken] to it's
/// subtree, making a darkened screen effect.
///
/// Do note that this widget has nothing (yet) to do with the night-light of
/// OS/native platform. It just simply apply specific [BlendMode] to it's
/// children.
class NightReader extends StatelessWidget {
  const NightReader({
    Key? key,
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
        super(key: key);

  /// The current value of darkened progress, this value must be within range
  /// [0 - 1]. This property can be animated with [AnimationController] or
  /// any type of mechanism that trigger a [State.setState]. In case of one
  /// need to simply animating between values, the use of [AnimatedNightReader]
  /// should be considered.
  final double value;

  /// The color that this widget will apply to the subtree with specific
  /// [BlendMode].
  final Color tint;

  /// At each value of [value], the opacity of [tint] will [lerpDouble] from
  /// [minTintOpacity] to [maxTintOpacity], making the subtree below this
  /// widgets blended with such color.
  ///
  /// These values must range from [0-1].
  final double minTintOpacity;
  final double maxTintOpacity;

  /// The darkened of the subtree, however, is control by [minDarkenOpacity]
  /// and [maxDarkenOpacity]. At each value of [value], the subtree will be
  /// darkened by [lerpDouble] between [minDarkenOpacity] and
  /// [maxDarkenOpacity], making the screen go darker. Were [maxDarkenOpacity]
  /// set to 1., the screen will be completely black when [value] is 1.
  ///
  /// These values must range from [0-1].
  final double minDarkenOpacity;
  final double maxDarkenOpacity;

  /// The subtree/child/widget bellow this widget.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return _NightReader(
      value: value,
      tint: tint,
      maxDarkenOpacity: maxDarkenOpacity,
      minDarkenOpacity: minDarkenOpacity,
      minTintOpacity: minTintOpacity,
      maxTintOpacity: maxTintOpacity,
      child: child,
    );
  }
}

class _NightReader extends SingleChildRenderObjectWidget {
  const _NightReader({
    Key? key,
    required this.value,
    required this.tint,
    required Widget child,
    required this.maxDarkenOpacity,
    required this.minDarkenOpacity,
    required this.maxTintOpacity,
    required this.minTintOpacity,
  }) : super(key: key, child: child);
  final double value;
  final Color tint;
  final double minDarkenOpacity;
  final double maxDarkenOpacity;
  final double minTintOpacity;
  final double maxTintOpacity;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderNightReader(
      t: value,
      tint: tint,
      maxDarkenOpacity: maxDarkenOpacity,
      minDarkenOpacity: minDarkenOpacity,
      maxTintOpacity: maxTintOpacity,
      minTintOpacity: minTintOpacity,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant _RenderNightReader renderObject) {
    renderObject
      ..t = value
      ..tint = tint
      ..minDarkenOpacity = minDarkenOpacity
      ..maxDarkenOpacity = maxDarkenOpacity
      ..minTintOpacity = minTintOpacity
      ..maxTintOpacity = maxTintOpacity;
  }
}

class _RenderNightReader extends RenderProxyBox {
  _RenderNightReader({
    required double t,
    required Color tint,
    required double minDarkenOpacity,
    required double maxDarkenOpacity,
    required double minTintOpacity,
    required double maxTintOpacity,
  })  : _t = t,
        _tint = tint,
        _minDarkenOpacity = minDarkenOpacity,
        _maxDarkenOpacity = maxDarkenOpacity,
        _minTintOpacity = minTintOpacity,
        _maxTintOpacity = maxTintOpacity;

  double _t;

  double get t => _t;

  set t(double value) {
    if (_t != value) {
      _t = value;
      markNeedsPaint();
    }
  }

  Color _tint;

  Color get tint => _tint;

  set tint(Color value) {
    if (_tint != value) {
      _tint = value;
      markNeedsPaint();
    }
  }

  double _minDarkenOpacity;

  double get minDarkenOpacity => _minDarkenOpacity;

  set minDarkenOpacity(double value) {
    if (_minDarkenOpacity != value) {
      _minDarkenOpacity = value;
      markNeedsPaint();
    }
  }

  double _maxDarkenOpacity;

  double get maxDarkenOpacity => _maxDarkenOpacity;

  set maxDarkenOpacity(double value) {
    if (_maxDarkenOpacity != value) {
      _maxDarkenOpacity = value;
      markNeedsPaint();
    }
  }

  double _minTintOpacity;

  double get minTintOpacity => _minTintOpacity;

  set minTintOpacity(double value) {
    if (value != _minTintOpacity) {
      _minTintOpacity = value;
      markNeedsPaint();
    }
  }

  double _maxTintOpacity;

  double get maxTintOpacity => _maxTintOpacity;

  set maxTintOpacity(double value) {
    if (value != _maxTintOpacity) {
      _maxTintOpacity = value;
      markNeedsPaint();
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint();
    context.canvas.saveLayer(offset & size, paint);
    super.paint(context, offset);
    final darkenOpacity =
        lerpDouble(minDarkenOpacity, maxDarkenOpacity, t) ?? 0;
    final tintOpacity = lerpDouble(minTintOpacity, maxTintOpacity, t) ?? 0;
    context.canvas.drawColor(tint.withOpacity(tintOpacity), BlendMode.darken);
    context.canvas.drawColor(
      Colors.black.withOpacity(darkenOpacity),
      BlendMode.darken,
    );
    context.canvas.restore();
  }
}
