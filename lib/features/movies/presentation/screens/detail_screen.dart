import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Constants/api_constants.dart';
import '../../../../core/responsive/responsive.dart';
import '../../domain/entities/movie_detail_entity.dart';
import '../widgets/custom_mobile_layout.dart';
import '../widgets/custom_tablet_layout.dart';

class Detailscreen extends StatelessWidget {
  final ResultEntity result;
  const Detailscreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(result!.id!.toString()),
        centerTitle: false,
        elevation: 0,
        leading: IconButton(
          onPressed: (){
            context.pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: colors.onBackground,
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



