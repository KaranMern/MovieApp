import 'package:flutter/material.dart';

import 'package:sample/core/Constants/api_constants.dart';
import 'package:sample/core/responsive/responsive.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/presentation/widgets/detail_screen_footer.dart';
import 'package:sample/features/movies/presentation/widgets/details_screen_header.dart';

/// Tablet/desktop detail layout: poster [ImageHeader] in a fixed-width column (42% of width),
/// scrollable [DetailScreen_Footer] in the remaining space.
class TabletLayout extends StatelessWidget {
  const TabletLayout({
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: r.w * 0.42,
          height: double.infinity,
          child: ImageHeader(
            imagePath: '${ApiConstants.imageUrl}${result.posterPath}',
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: DetailScreen_Footer(result: result),
          ),
        ),
      ],
    );
  }
}
