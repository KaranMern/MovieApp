import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample/core/responsive/responsive.dart';

/// Full-width (or fixed height on mobile) movie poster/backdrop with rounded
/// bottom corners. Shows loading progress or broken-image icon on error.
class ImageHeader extends StatelessWidget {
  const ImageHeader({required this.imagePath, super.key});
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: r.imageHeaderRadius,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        width: double.infinity,
        height: r.detailImageHeight,
        fit: BoxFit.contain,

        placeholder: (context, url) => SizedBox(
          height: r.detailImageHeight,
          child: Center(
            child: CircularProgressIndicator(
              color: colors.primary,
            ),
          ),
        ),

        errorWidget: (context, url, error) => SizedBox(
          height: r.detailImageHeight,
          child: Center(
            child: Icon(
              Icons.broken_image,
              color: colors.onSurface,
              size: r.iconSizeLarge,
            ),
          ),
        ),
      ),
    );
  }
}
