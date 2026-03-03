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
          Text(result.title ?? "", style: r.titleStyle(colors.onBackground)),
          SizedBox(height: r.spacingM),

          Text(Constants.overview, style: r.headingStyle(colors.onBackground)),
          SizedBox(height: r.spacingS),

          Text(result.overview ?? "", style: r.bodyStyle(colors.onBackground)),
          SizedBox(height: r.spacingM),

          Text(
            Constants.language,
            style: r.subHeadingStyle(colors.onBackground),
          ),
          SizedBox(height: r.spacingXS),

          Text(
            result.originalLanguage ?? "",
            style: r.bodyStyle(colors.onBackground),
          ),
          SizedBox(height: r.spacingM),

          Text(
            Constants.popularity,
            style: r.subHeadingStyle(colors.onBackground),
          ),
          SizedBox(height: r.spacingXS),

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
