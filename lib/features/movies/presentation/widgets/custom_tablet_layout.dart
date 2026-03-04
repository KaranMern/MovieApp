import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/api_constants.dart';
import '../../../../core/responsive/responsive.dart';
import '../../domain/entities/movie_detail_entity.dart';
import 'detail_screen_footer.dart';
import 'details_screen_header.dart';

class TabletLayout extends StatelessWidget {
  final ResultEntity result;
  final TextTheme textTheme;
  final ColorScheme colors;

  const TabletLayout({
    required this.result,
    required this.textTheme,
    required this.colors,
  });

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
            imagePath: "${ApiConstants.imageUrl}${result.posterPath}",
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
