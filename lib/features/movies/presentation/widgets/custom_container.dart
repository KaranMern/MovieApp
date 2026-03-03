import 'package:flutter/material.dart';
import 'package:sample/core/Constants/api_constants.dart';

import '../../../../core/responsive/responsive.dart';

class CustomCard extends StatelessWidget {
  final String posterPath;
  final String title;
  final VoidCallback onPressed;
  final String releaseDate;
  final int voteAverage;

  const CustomCard({
    super.key,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(r.radiusM),
          border: Border.all(color: colors.primary),
          color: colors.surface,
        ),
        padding: r.cardPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image + Rating Badge
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(r.radiusM),
                    child: Image.network(
                      "${ApiConstants.imageUrl}$posterPath",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: colors.primary,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(
                          Icons.broken_image,
                          color: colors.onSurface,
                          size: r.iconSizeLarge,
                        ),
                      ),
                    ),
                  ),

                  // Rating Badge
                  Positioned(
                    right: r.paddingS * 0.3,
                    top: r.paddingS * 0.3,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: r.w * 0.015,
                        vertical: r.h * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(r.radiusS),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            size: r.captionSize,
                            color: Colors.white,
                          ),
                          SizedBox(width: r.w * 0.008),
                          Text(
                            voteAverage.toStringAsFixed(1),
                            style: r.captionStyle(
                              Colors.white,
                              weight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: r.spacingS),

            // Title
            Flexible(
              flex: 1,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: r.bodyStyle(
                  colors.onBackground,
                  weight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: r.spacingXS),

            // Release Date
            Text(
              releaseDate,
              style: r.captionStyle(colors.onBackground.withOpacity(0.7)),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
