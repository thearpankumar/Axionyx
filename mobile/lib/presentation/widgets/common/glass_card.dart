import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../core/theme/color_schemes.dart';
import '../../../core/constants/app_constants.dart';

/// Glassmorphic card widget with frosted glass effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Color? color;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final double blurSigma;

  const GlassCard({
    super.key,
    required this.child,
    this.borderRadius = AppConstants.cardBorderRadius,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.onTap,
    this.color,
    this.border,
    this.boxShadow,
    this.blurSigma = AppConstants.glassBlurSigma,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultColor =
        isDark ? AppColorSchemes.glassDark : AppColorSchemes.glassLight;

    final defaultBorder = border ??
        Border.all(
          color: isDark
              ? AppColorSchemes.glassDarkBorder
              : AppColorSchemes.glassLightBorder,
          width: 1,
        );

    final defaultShadow = boxShadow ??
        [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ];

    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: defaultBorder,
        boxShadow: defaultShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
          child: Container(
            decoration: BoxDecoration(
              color: color ?? defaultColor,
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: isDark
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.08),
                        Colors.white.withValues(alpha: 0.03),
                      ],
                    )
                  : null,
            ),
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}

/// Glassmorphic card with hero animation support
class GlassHeroCard extends StatelessWidget {
  final String heroTag;
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  const GlassHeroCard({
    super.key,
    required this.heroTag,
    required this.child,
    this.borderRadius = AppConstants.cardBorderRadius,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag,
      child: Material(
        color: Colors.transparent,
        child: GlassCard(
          borderRadius: borderRadius,
          padding: padding,
          margin: margin,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
