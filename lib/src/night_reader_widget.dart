import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  final double value;
  final Color tint;
  final double minDarkenOpacity;
  final double maxDarkenOpacity;
  final double minTintOpacity;
  final double maxTintOpacity;
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
