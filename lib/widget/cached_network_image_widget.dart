import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// A reusable wrapper around [CachedNetworkImage] with simplified configuration.
///
/// This widget provides:
/// - automatic caching for network images
/// - custom image builder support
/// - consistent placeholder & error layout
/// - configurable size and box fit
///
/// The widget avoids layout jumps by assigning identical
/// placeholder and error widgets based on width/height.
class CachedNetworkImageWidget extends StatelessWidget {
  const CachedNetworkImageWidget({
    required this.imageUrl,
    super.key,
    this.imageBuilder,
    this.fit,
    this.width,
    this.height,
  });

  /// Target image URL to load.
  final String? imageUrl;

  /// Optional custom builder for rendering the loaded image.
  ///
  /// Example:
  /// ```dart
  /// imageBuilder: (context, provider) => CircleAvatar(backgroundImage: provider),
  /// ```
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;

  /// Defines how the image should be resized within its bounds.
  final BoxFit? fit;

  /// Fixed width for the image container.
  final double? width;

  /// Fixed height for the image container.
  final double? height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      /// Displays a placeholder with the same dimensions,
      /// preventing layout shifts during image loading.
      placeholder: (context, url) => SizedBox(width: width, height: height),

      /// Fallback widget in case loading fails.
      errorWidget: (context, url, error) => SizedBox(width: width, height: height),

      /// URL to be loaded (empty string if null to prevent crash).
      imageUrl: imageUrl ?? '',

      /// Use custom builder if provided.
      imageBuilder: imageBuilder,

      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,

      /// Custom cache manager with 3-hour stale period.
      ///
      /// This ensures updated weather icons or dynamic network images
      /// refresh periodically while still benefiting from caching.
      cacheManager: CacheManager(Config('CachedNetworkImageKey', stalePeriod: const Duration(hours: 3))),
    );
  }
}
