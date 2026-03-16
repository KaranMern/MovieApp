import 'package:flutter/material.dart';

import 'package:sample/core/Constants/api_constants.dart';
import 'package:sample/core/responsive/responsive.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/presentation/widgets/detail_screen_footer.dart';
import 'package:sample/features/movies/presentation/widgets/details_screen_header.dart';

/// Mobile detail layout: full-width [ImageHeader] on top, then [DetailScreen_Footer]
/// with title, overview, language, and popularity.
class MobileLayout extends StatelessWidget {
  const MobileLayout({
    required this.result,
    required this.textTheme,
    required this.colors,
    super.key,
  });
  final ResultEntity result;
  final TextTheme textTheme;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageHeader(
            imagePath: '${ApiConstants.imageUrl}${result.posterPath}',
          ),
          SizedBox(height: r.spacingM),
          DetailScreen_Footer(result: result),
        ],
      ),
    );
  }
}
