import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive.dart';

class CustomAppBar extends StatefulWidget {
  final String title;
  final bool isDark;
  final ValueChanged<bool> onChanged;
  const CustomAppBar({
    super.key,
    required this.title,
    required this.onChanged,
    required this.isDark,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
    isDark = widget.isDark;
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final colors = Theme.of(context).colorScheme;

    return Container(
      padding: r.appBarPadding,
      color: colors.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.movie_filter_sharp,
            color: Colors.red,
            size: r.iconSizeLarge,
          ),
          SizedBox(width: r.paddingS),
          Expanded(
            child: Text(
              widget.title,
              style: r.appBarTitleStyle(colors.onPrimary),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() => isDark = !isDark);
              widget.onChanged(isDark);
            },
            iconSize: r.iconSizeMedium,
            icon: isDark
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.sunny),
            color: colors.onPrimary,
          ),
        ],
      ),
    );
  }
}
