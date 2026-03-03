import 'package:flutter/material.dart';
import '../../../../core/Constants/api_constants.dart';
import '../../../../core/responsive/responsive.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../Widgets/details_screen_header.dart';
import '../Widgets/detail_screen_footer.dart';

class Detailscreen extends StatelessWidget {
  final ResultEntity result;
  const Detailscreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: colors.onBackground,
            size: r.iconSizeMedium,
          ),
        ),
      ),
      body: r.isMobile
          ? _MobileLayout(result: result)
          : _TabletLayout(result: result),
    );
  }
}

class _MobileLayout extends StatelessWidget {
  final ResultEntity result;
  const _MobileLayout({required this.result});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageHeader(
            ImagePath: "${ApiConstants.imageUrl}${result.posterPath}",
          ),
          SizedBox(height: r.spacingM),
          DetailScreen_Footer(result: result),
        ],
      ),
    );
  }
}

class _TabletLayout extends StatelessWidget {
  final ResultEntity result;
  const _TabletLayout({required this.result});

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
            ImagePath: "${ApiConstants.imageUrl}${result.posterPath}",
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