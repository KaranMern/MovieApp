import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/core/responsive/responsive.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/presentation/widgets/custom_mobile_layout.dart';
import 'package:sample/features/movies/presentation/widgets/custom_tablet_layout.dart';

/// Detail screen for a single movie. Shows [result] in [MobileLayout] or
/// [TabletLayout] based on [Responsive.isMobile]. App bar shows movie id
/// and back button that calls [context.pop].
class Detailscreen extends StatelessWidget {
  const Detailscreen({required this.result, super.key});
  final ResultEntity result;

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.tertiary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(result.id?.toString() ?? 'Unknown'),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: colors.onSurface,
            size: r.iconSizeMedium,
          ),
        ),
      ),
      body: r.isMobile
          ? MobileLayout(result: result, textTheme: textTheme, colors: colors)
          : TabletLayout(result: result, textTheme: textTheme, colors: colors),
    );
  }
}
