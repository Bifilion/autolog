import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BoxDecoration? decoration;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(24);

    Widget card = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: padding,

      decoration:
          decoration ??
          BoxDecoration(
            color: const Color(0xFFF7F7FD),
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.9),
                offset: const Offset(-4, -4),
                blurRadius: 10,
              ),
              BoxShadow(
                color: const Color(0xFFD0D3E8),
                offset: const Offset(6, 6),
                blurRadius: 14,
              ),
            ],
          ),

      child: child,
    );

    if (onTap != null) {
      card = Material(
        color: Colors.transparent,
        child: InkWell(borderRadius: radius, onTap: onTap, child: card),
      );
    }

    return Padding(padding: margin, child: card);
  }
}
