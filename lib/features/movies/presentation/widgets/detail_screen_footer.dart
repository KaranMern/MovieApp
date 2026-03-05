import 'package:flutter/material.dart';
import 'package:sample/core/Constants/string_constants.dart';
import 'package:sample/core/responsive/responsive.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';

/// Footer section of the detail screen: title, overview, language, and popularity
/// using [Responsive] text styles and [Constants] for section labels.
class DetailScreen_Footer extends StatelessWidget {
  const DetailScreen_Footer({required this.result, super.key});
  final ResultEntity result;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: r.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie Title
          Text(result.title ?? '', style: r.titleStyle(colors.surfaceContainer)),
          Divider(thickness: 1, color: colors.surfaceContainer, endIndent: 7),
          SizedBox(height: r.spacingM),
          // Overview Heading
          Text(Constants.overview, style: r.headingStyle(colors.surfaceContainer)),
          SizedBox(height: r.spacingS),

          // Overview Text
          Text(result.overview ?? '', style: r.bodyStyle(colors.surfaceContainer)),
          SizedBox(height: r.spacingM),

          // Language Heading
          Text(
            Constants.language,
            style: r.subHeadingStyle(colors.surfaceContainer),
          ),
          SizedBox(height: r.spacingXS),

          // Original Language
          Text(
            result.originalLanguage ?? '',
            style: r.bodyStyle(colors.surfaceContainer),
          ),
          SizedBox(height: r.spacingM),

          // Popularity Heading
          Text(
            Constants.popularity,
            style: r.subHeadingStyle(colors.surfaceContainer),
          ),
          SizedBox(height: r.spacingXS),

          // Popularity Value
          Text(
            result.popularity?.toString() ?? '',
            style: r.bodyStyle(colors.surfaceContainer),
          ),
          SizedBox(height: r.spacingXL),
        ],
      ),
    );
  }
}
