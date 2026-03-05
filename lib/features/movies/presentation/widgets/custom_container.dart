import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sample/core/Constants/api_constants.dart';
import 'package:sample/core/responsive/responsive.dart';

/// Card for a single movie: poster image, rating badge, title, release date.
/// Tapping triggers [onPressed]. Uses [ApiConstants.imageUrl] + [posterPath]
/// for the image URL and [CachedNetworkImage] for loading/error states.
class CustomCard extends StatelessWidget {
  const CustomCard({
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.voteAverage,
    required this.onPressed,
    super.key,
  });
  final String posterPath;
  final String title;
  final VoidCallback onPressed;
  final String releaseDate;
  final int voteAverage;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final textTheme = theme.textTheme;

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
          children: [
            // Image + Rating Badge
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(r.radiusM),
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConstants.imageUrl}$posterPath',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: colors.primary,
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
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
                            style: textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
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
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.surfaceContainer,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            SizedBox(height: r.spacingXS),

            // Release Date
            Text(
              releaseDate,
              style: textTheme.bodySmall?.copyWith(
                color: colors.surfaceContainer.withOpacity(0.7),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
