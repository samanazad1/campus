import 'package:flutter/material.dart';


/// Signature for a callback function used to report
/// dot tap-events
typedef OnDotClicked = void Function(int index);

/// A widget that draws a representation of pages count
/// Inside of a  [PageView]
///
/// Uses the [PageController.offset] to animate the active dot
class SmoothPageIndicator extends StatefulWidget {
  /// The page view controller
  final PageController controller;

  /// Holds effect configuration to be used in the [BasicIndicatorPainter]
  final IndicatorEffect effect;

  /// Layout direction vertical || horizontal
  ///
  /// This will only rotate the canvas in which the dots are drawn.
  ///
  /// It will not affect [effect.dotWidth] and [effect.dotHeight]
  final Axis axisDirection;

  /// The number of pages
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection? textDirection;

  /// Reports dot taps
  final OnDotClicked? onDotClicked;

  /// Default constructor
  const SmoothPageIndicator({
    Key? key,
    required this.controller,
    required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
  }) : super(key: key);

  @override
  State<SmoothPageIndicator> createState() => _SmoothPageIndicatorState();
}

mixin _SizeAndRotationCalculatorMixin {
  /// The size of canvas
  late Size size;

  /// Rotation quarters of canvas
  int quarterTurns = 0;

  BuildContext get context;

  TextDirection? get textDirection;

  Axis get axisDirection;

  int get count;

  IndicatorEffect get effect;

  void updateSizeAndRotation() {
    size = effect.calculateSize(count);

    /// if textDirection is not provided use the nearest directionality up the widgets tree;
    final isRTL = (textDirection ?? _getDirectionality()) == TextDirection.rtl;
    if (axisDirection == Axis.vertical) {
      quarterTurns = 1;
    } else {
      quarterTurns = isRTL ? 2 : 0;
    }
  }

  TextDirection? _getDirectionality() {
    return context
        .findAncestorWidgetOfExactType<Directionality>()
        ?.textDirection;
  }
}

class _SmoothPageIndicatorState extends State<SmoothPageIndicator>
    with _SizeAndRotationCalculatorMixin {
  @override
  void initState() {
    super.initState();
    updateSizeAndRotation();
  }

  @override
  void didUpdateWidget(covariant SmoothPageIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateSizeAndRotation();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, _) => SmoothIndicator(
        offset: _offset,
        count: count,
        effect: effect,
        onDotClicked: widget.onDotClicked,
        size: size,
        quarterTurns: quarterTurns,
      ),
    );
  }

  double get _offset {
    try {
      var offset =
          widget.controller.page ?? widget.controller.initialPage.toDouble();
      return offset % widget.count;
    } catch (_) {
      return widget.controller.initialPage.toDouble();
    }
  }

  @override
  int get count => widget.count;

  @override
  IndicatorEffect get effect => widget.effect;

  @override
  Axis get axisDirection => widget.axisDirection;

  @override
  TextDirection? get textDirection => widget.textDirection;
}

/// Draws dot-ish representation of pages by
/// the number of [count] and animates the active
/// page using [offset]
class SmoothIndicator extends StatelessWidget {
  /// The active page offset
  final double offset;

  /// Holds effect configuration to be used in the [BasicIndicatorPainter]
  final IndicatorEffect effect;

  /// The number of pages
  final int count;

  /// Reports dot-taps
  final OnDotClicked? onDotClicked;

  /// The size of canvas
  final Size size;

  /// The rotation of cans based on
  /// text directionality and [axisDirection]
  final int quarterTurns;

  /// Default constructor
  const SmoothIndicator({
    Key? key,
    required this.offset,
    required this.count,
    required this.size,
    this.quarterTurns = 0,
    this.effect = const WormEffect(),
    this.onDotClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: GestureDetector(
        onTapUp: _onTap,
        child: CustomPaint(
          size: size,
          // rebuild the painter with the new offset every time it updates
          painter: effect.buildPainter(count, offset),
        ),
      ),
    );
  }

  void _onTap(details) {
    if (onDotClicked != null) {
      var index = effect.hitTestDots(details.localPosition.dx, count, offset);
      if (index != -1 && index != offset.toInt()) {
        onDotClicked?.call(index);
      }
    }
  }
}

/// Unlike [SmoothPageIndicator] this indicator is self-animated
/// and it only needs to know active index
///
/// Useful for paging widgets that does not use [PageController]
class AnimatedSmoothIndicator extends ImplicitlyAnimatedWidget {
  /// The index of active page
  final int activeIndex;

  /// Holds effect configuration to be used in the [BasicIndicatorPainter]
  final IndicatorEffect effect;

  /// layout direction vertical || horizontal
  final Axis axisDirection;

  /// The number of children in [PageView]
  final int count;

  /// If [textDirection] is [TextDirection.rtl], page direction will be flipped
  final TextDirection? textDirection;

  /// Reports dot-taps
  final Function(int index)? onDotClicked;

  /// Default constructor
  const AnimatedSmoothIndicator({
    Key? key,
    required this.activeIndex,
    required this.count,
    this.axisDirection = Axis.horizontal,
    this.textDirection,
    this.onDotClicked,
    this.effect = const WormEffect(),
    Curve curve = Curves.easeInOut,
    Duration duration = const Duration(milliseconds: 300),
    VoidCallback? onEnd,
  }) : super(
          key: key,
          duration: duration,
          curve: curve,
          onEnd: onEnd,
        );

  @override
  AnimatedWidgetBaseState<AnimatedSmoothIndicator> createState() =>
      _AnimatedSmoothIndicatorState();
}

class _AnimatedSmoothIndicatorState
    extends AnimatedWidgetBaseState<AnimatedSmoothIndicator>
    with _SizeAndRotationCalculatorMixin {
  Tween<double>? _offset;

  @override
  void initState() {
    super.initState();
    updateSizeAndRotation();
  }

  @override
  void didUpdateWidget(covariant AnimatedSmoothIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    updateSizeAndRotation();
  }

  @override
  void forEachTween(visitor) {
    _offset = visitor(
      _offset,
      widget.activeIndex.toDouble(),
      (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>;
  }

  @override
  int get count => widget.count;

  @override
  IndicatorEffect get effect => widget.effect;

  @override
  Axis get axisDirection => widget.axisDirection;

  @override
  TextDirection? get textDirection => widget.textDirection;

  @override
  Widget build(BuildContext context) {
    final offset = _offset;
    if (offset == null) {
      throw 'Offset has not been initialized';
    }
    return SmoothIndicator(
      offset: offset.evaluate(animation),
      count: widget.count,
      effect: widget.effect,
      onDotClicked: widget.onDotClicked,
      size: size,
      quarterTurns: quarterTurns,
    );
  }
}

/// An Abstraction for a dot-indicator animation effect
abstract class IndicatorEffect {
  /// Const constructor
  const IndicatorEffect();

  /// Builds a new painter every time the page offset changes
  IndicatorPainter buildPainter(int count, double offset);

  /// Calculates the size of canvas based on
  /// dots count, size and spacing
  ///
  /// Implementers can override this function
  /// to calculate their own size
  Size calculateSize(int count);

  /// Returns the index of the section that contains [dx].
  ///
  /// Sections or hit-targets are calculated differently
  /// in some effects
  int hitTestDots(double dx, int count, double current);
}

/// Basic implementation of [IndicatorEffect] that holds some shared
/// properties and behaviors between different effects
abstract class BasicIndicatorEffect extends IndicatorEffect {
  /// Singe dot width
  final double dotWidth;

  /// Singe dot height
  final double dotHeight;

  /// The horizontal space between dots
  final double spacing;

  /// Single dot radius
  final double radius;

  /// Inactive dots color or all dots in some effects
  final Color dotColor;

  /// The active dot color
  final Color activeDotColor;

  /// Inactive dots paint style (fill|stroke) defaults to fill.
  final PaintingStyle paintStyle;

  /// This is ignored if [paintStyle] is PaintStyle.fill
  final double strokeWidth;

  /// Default construe
  const BasicIndicatorEffect({
    required this.strokeWidth,
    required this.dotWidth,
    required this.dotHeight,
    required this.spacing,
    required this.radius,
    required this.dotColor,
    required this.paintStyle,
    required this.activeDotColor,
  }) : assert(dotWidth >= 0 &&
            dotHeight >= 0 &&
            spacing >= 0 &&
            strokeWidth >= 0);

  @override
  Size calculateSize(int count) {
    return Size(dotWidth * count + (spacing * (count - 1)), dotHeight);
  }

  @override
  int hitTestDots(double dx, int count, double current) {
    var offset = -spacing / 2;
    for (var index = 0; index < count; index++) {
      if (dx <= (offset += dotWidth + spacing)) {
        return index;
      }
    }
    return -1;
  }
}

/// Basic implementation of [IndicatorPainter] that holds some shared
/// properties and behaviors between different painters
abstract class BasicIndicatorPainter extends IndicatorPainter {
  /// The count of pages
  final int count;

  /// The provided effect is passed to this super class
  /// to make some calculations and paint still dots
  final BasicIndicatorEffect _effect;

  /// Inactive dot paint or base paint in one-color effects.
  final Paint dotPaint;

  /// The Radius of all dots
  final Radius dotRadius;

  /// Default constructor
  BasicIndicatorPainter(
    double offset,
    this.count,
    this._effect,
  )   : dotRadius = Radius.circular(_effect.radius),
        dotPaint = Paint()
          ..color = _effect.dotColor
          ..style = _effect.paintStyle
          ..strokeWidth = _effect.strokeWidth,
        super(offset);

  /// The distance between dot lefts
  double get distance => _effect.dotWidth + _effect.spacing;

  /// Paints [count] number of dots with no animation
  ///
  /// Meant to be used by  effects that only
  /// animate the active dot
  void paintStillDots(Canvas canvas, Size size) {
    for (var i = 0; i < count; i++) {
      final rect = buildStillDot(i, size);
      canvas.drawRRect(rect, dotPaint);
    }
  }

  /// Builds a single still dot
  RRect buildStillDot(int i, Size size) {
    final xPos = (i * distance);
    final yPos = size.height / 2;
    final bounds = Rect.fromLTRB(
      xPos,
      yPos - _effect.dotHeight / 2,
      xPos + _effect.dotWidth,
      yPos + _effect.dotHeight / 2,
    );
    var rect = RRect.fromRectAndRadius(bounds, dotRadius);
    return rect;
  }

  /// Masks spaces between dots
  ///
  /// used by under-layer effects like WormType.underground
  void maskStillDots(Size size, Canvas canvas) {
    var path = Path()..addRect((const Offset(0, 0) & size));
    for (var i = 0; i < count; i++) {
      path = Path.combine(PathOperation.difference, path,
          Path()..addRRect(buildStillDot(i, size)));
    }
    canvas.drawPath(path, Paint()..blendMode = BlendMode.clear);
  }

  /// Calculates the shape of a dot while portal-traveling
  /// form last-to-first dot or form first-to-last dot
  RRect calcPortalTravel(Size size, double offset, double dotOffset) {
    final yPos = size.height / 2;
    var width = dotOffset * (_effect.dotHeight / 2);
    var height = dotOffset * (_effect.dotWidth / 2);
    var xPos = offset;
    return RRect.fromLTRBR(
      xPos - height,
      yPos - width,
      xPos + height,
      yPos + width,
      Radius.circular(dotRadius.x * dotOffset),
    );
  }
}

/// A basic abstract implementation of [customPainter]
/// to avoid overriding [shouldRepaint] in every painter
abstract class IndicatorPainter extends CustomPainter {
  /// The raw offset from the [PageController].page
  final double offset;

  /// Default constructor
  const IndicatorPainter(this.offset);

  @override
  bool shouldRepaint(IndicatorPainter oldDelegate) {
    /// only repaint if the offset changes
    return oldDelegate.offset != offset;
  }
}

/// Holds painting configuration to be used by [WormPainter]
class WormEffect extends BasicIndicatorEffect {
  /// The effect variant
  ///
  /// defaults to [WormType.normal]
  final WormType type;

  /// Default constructor
  const WormEffect({
    double offset = 16.0,
    double dotWidth = 16.0,
    double dotHeight = 16.0,
    double spacing = 8.0,
    double radius = 16,
    Color dotColor = Colors.grey,
    Color activeDotColor = Colors.indigo,
    double strokeWidth = 1.0,
    PaintingStyle paintStyle = PaintingStyle.fill,
    this.type = WormType.normal,
  }) : super(
          dotWidth: dotWidth,
          dotHeight: dotHeight,
          spacing: spacing,
          radius: radius,
          strokeWidth: strokeWidth,
          paintStyle: paintStyle,
          dotColor: dotColor,
          activeDotColor: activeDotColor,
        );

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return WormPainter(count: count, offset: offset, effect: this);
  }
}

/// The Worm effect variants
enum WormType {
  /// Draws normal worm animation
  normal,

  /// Draws a thin worm animation
  thin,

  /// Draws normal worm animation that looks like
  /// it's under the background
  underground,

  /// Draws a thing worm animation that looks like
  /// it's under the background
  thinUnderground,
}

/// Paints a warm-like transition effect between active
/// and non-active dots
///
/// Live demo at
/// https://github.com/Milad-Akarie/smooth_page_indicator/blob/f7ee92e7413a31de77bfb487755d64a385d52a52/demo/worm.gif
class WormPainter extends BasicIndicatorPainter {
  /// The painting configuration
  final WormEffect effect;

  /// Default constructor
  WormPainter({
    required this.effect,
    required int count,
    required double offset,
  }) : super(offset, count, effect);

  @override
  void paint(Canvas canvas, Size size) {
    // paint still dots
    paintStillDots(canvas, size);

    final activeDotPaint = Paint()..color = effect.activeDotColor;
    final dotOffset = (offset - offset.toInt());

    // handle dot travel from end to start (for infinite pager support)
    if (offset > count - 1) {
      final startDot = calcPortalTravel(size, effect.dotWidth / 2, dotOffset);
      canvas.drawRRect(startDot, activeDotPaint);

      final endDot = calcPortalTravel(
        size,
        ((count - 1) * distance) + (effect.dotWidth / 2),
        1 - dotOffset,
      );
      canvas.drawRRect(endDot, activeDotPaint);
      return;
    }

    final wormOffset = dotOffset * 2;
    final xPos = (offset.floor() * distance);
    final yPos = size.height / 2;
    var head = xPos;
    var tail = xPos + effect.dotWidth + (wormOffset * distance);
    var halfHeight = effect.dotHeight / 2;
    final thinWorm =
        effect.type == WormType.thin || effect.type == WormType.thinUnderground;
    var dotHeight = thinWorm
        ? halfHeight + (halfHeight * (1 - wormOffset))
        : effect.dotHeight;

    if (wormOffset > 1) {
      tail = xPos + effect.dotWidth + (1 * distance);
      head = xPos + distance * (wormOffset - 1);
      if (thinWorm) {
        dotHeight = halfHeight + (halfHeight * (wormOffset - 1));
      }
    }
    final worm = RRect.fromLTRBR(
      head,
      yPos - dotHeight / 2,
      tail,
      yPos + dotHeight / 2,
      dotRadius,
    );
    if (effect.type == WormType.underground ||
        effect.type == WormType.thinUnderground) {
      canvas.saveLayer(Rect.largest, Paint());
      canvas.drawRRect(worm, activeDotPaint);
      maskStillDots(size, canvas);
      canvas.restore();
    } else {
      canvas.drawRRect(worm, activeDotPaint);
    }
  }
}
