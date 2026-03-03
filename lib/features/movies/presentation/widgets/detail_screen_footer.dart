import 'package:flutter/material.dart';
import '../../../../core/Constants/string_constants.dart';
import '../../../../core/responsive/responsive.dart';
import '../../domain/entities/movie_detail_entity.dart';

class DetailScreen_Footer extends StatelessWidget {
  final ResultEntity result;
  const DetailScreen_Footer({super.key, required this.result});

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
          Text(result.title ?? "", style: r.titleStyle(colors.onBackground)),
          Divider(thickness: 1, color: colors.onBackground, endIndent: 7),
          SizedBox(height: r.spacingM),
          // Overview Heading
          Text(Constants.overview, style: r.headingStyle(colors.onBackground)),
          SizedBox(height: r.spacingS),

          // Overview Text
          Text(result.overview ?? "", style: r.bodyStyle(colors.onBackground)),
          SizedBox(height: r.spacingM),

          // Language Heading
          Text(
            Constants.language,
            style: r.subHeadingStyle(colors.onBackground),
          ),
          SizedBox(height: r.spacingXS),

          // Original Language
          Text(
            result.originalLanguage ?? "",
            style: r.bodyStyle(colors.onBackground),
          ),
          SizedBox(height: r.spacingM),

          // Popularity Heading
          Text(
            Constants.popularity,
            style: r.subHeadingStyle(colors.onBackground),
          ),
          SizedBox(height: r.spacingXS),

          // Popularity Value
          Text(
            result.popularity?.toString() ?? "",
            style: r.bodyStyle(colors.onBackground),
          ),
          SizedBox(height: r.spacingXL),
        ],
      ),
    );
  }
}
