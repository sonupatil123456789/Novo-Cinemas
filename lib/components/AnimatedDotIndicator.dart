import 'package:flutter/material.dart';

class AnimatedDotIndicator extends StatefulWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final double spacing;
  final Duration duration;

  const AnimatedDotIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    required this.activeColor ,
    required this.inactiveColor ,
    this.dotSize = 6.0,
    this.spacing = 6.0,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  @override
  State<AnimatedDotIndicator> createState() => _AnimatedDotIndicatorState();
}

class _AnimatedDotIndicatorState extends State<AnimatedDotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.count, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.spacing / 2),
          child: DotItem(
            isActive: index == widget.currentIndex,
            activeColor: widget.activeColor,
            inactiveColor: widget.inactiveColor,
            dotSize: widget.dotSize,
            duration: widget.duration,
          ),
        );
      }),
    );
  }
}

class DotItem extends StatefulWidget {
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final double dotSize;
  final Duration duration;

  const DotItem({
    Key? key,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.dotSize,
    required this.duration,
  }) : super(key: key);

  @override
  State<DotItem> createState() => _DotItemState();
}

class _DotItemState extends State<DotItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: widget.inactiveColor,
      end: widget.activeColor,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    if (widget.isActive) {
      _controller.forward();
    }
  }

  @override
  void didUpdateWidget(DotItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive != oldWidget.isActive) {
      if (widget.isActive) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: widget.isActive ? widget.dotSize + 10 : widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: _colorAnimation.value,
              borderRadius: BorderRadius.circular(30)
              // shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}