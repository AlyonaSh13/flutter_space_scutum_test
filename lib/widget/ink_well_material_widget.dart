import 'package:flutter/material.dart';

/// A reusable widget that provides a Material + InkWell ripple effect
/// over any child widget.
///
/// This is useful when you want to make a custom container or layout
/// behave like a button while preserving its visual design.
///
/// Features:
/// - Adds ripple and splash effect on top of any widget.
/// - Supports custom overlay color for pressed/highlight states.
/// - Handles rounded corners via [borderRadius].
/// - Transparent Material ensures InkWell works correctly.
///
/// Structure:
/// Stack(
///   child,            // visible content
///   Material + InkWell // touch layer
/// )
class InkWellMaterialWidget extends StatelessWidget {
  const InkWellMaterialWidget({
    required this.child,
    super.key,
    this.color,
    this.borderRadius = BorderRadius.zero,
    this.onTap,
  });

  /// The visual child on which the ripple effect will appear.
  final Widget child;

  /// Optional custom overlay color for InkWell (pressed highlight).
  final Color? color;

  /// Determines the shape of the InkWell splash and highlight.
  final BorderRadius borderRadius;

  /// Callback fired when the widget is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// Base widget that remains visible beneath the ripple effect.
        child,

        /// Positioned.fill ensures InkWell covers the entire child area.
        Positioned.fill(
          child: Material(
            /// Transparent Material is required for InkWell to work.
            color: Colors.transparent,
            child: InkWell(
              /// When `color` is set, disable default highlight behavior.
              highlightColor: color != null ? Colors.transparent : null,

              /// Overlay (splash/highlight) color if provided.
              overlayColor: color != null ? WidgetStateProperty.all(color) : null,

              /// Match InkWell shape with provided border radius.
              borderRadius: borderRadius,

              /// Tap interaction callback.
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }
}
