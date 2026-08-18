import 'package:flutter/material.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;

  final EdgeInsetsGeometry padding;

  final BorderRadius borderRadius;

  final Color color;

  final bool pressed;

  const NeumorphicContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(12),
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
    this.color = const Color(0xFFF5F6FB),
    this.pressed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,

      decoration: BoxDecoration(
        color: color,

        borderRadius: borderRadius,

        boxShadow: pressed
            ? [
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.7),
                  offset: const Offset(-3, -3),
                  blurRadius: 8,
                ),

                BoxShadow(
                  color: const Color(0xFFCCD0DD).withValues(alpha: 0.6),
                  offset: const Offset(3, 3),
                  blurRadius: 8,
                ),
              ]
            : [
                BoxShadow(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.8),
                  offset: const Offset(-4, -4),
                  blurRadius: 10,
                ),

                BoxShadow(
                  color: const Color(0xFFCCD0DD).withValues(alpha: 0.6),
                  offset: const Offset(4, 4),
                  blurRadius: 10,
                ),
              ],
      ),

      child: child,
    );
  }
}
