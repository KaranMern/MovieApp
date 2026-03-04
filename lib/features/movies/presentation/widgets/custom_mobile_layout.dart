import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/Constants/api_constants.dart';
import '../../../../core/responsive/responsive.dart';
import '../../domain/entities/movie_detail_entity.dart';
import 'detail_screen_footer.dart';
import 'details_screen_header.dart';

class MobileLayout extends StatelessWidget {
  final ResultEntity result;
  final TextTheme textTheme;
  final ColorScheme colors;

  const MobileLayout({
    required this.result,
    required this.textTheme,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageHeader(
            imagePath: "${ApiConstants.imageUrl}${result.posterPath}",
          ),
          SizedBox(height: r.spacingM),
          DetailScreen_Footer(result: result),
        ],
      ),
    );
  }
}
