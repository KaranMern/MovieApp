import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';

class ImageHeader extends StatelessWidget {
  final String imagePath;
  const ImageHeader({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: r.imageHeaderRadius,
      child: Image.network(
        imagePath,
        width: double.infinity,
        height: r.detailImageHeight,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: r.detailImageHeight,
            child: Center(
              child: CircularProgressIndicator(
                color: colors.primary,
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) => SizedBox(
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