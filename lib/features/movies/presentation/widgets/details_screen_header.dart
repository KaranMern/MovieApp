import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';

class ImageHeader extends StatelessWidget {
  final String ImagePath;
  const ImageHeader({super.key, required this.ImagePath});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return ClipRRect(
      borderRadius: r.imageHeaderRadius,
      child: Image.network(
        ImagePath,
        width: double.infinity,
        height: r.detailImageHeight,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: r.detailImageHeight,
            child: Center(
              child: CircularProgressIndicator(
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
          child: const Center(child: Icon(Icons.broken_image)),
        ),
      ),
    );
  }
}