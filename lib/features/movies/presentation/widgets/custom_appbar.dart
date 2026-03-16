import 'package:flutter/material.dart';
import 'package:sample/core/responsive/responsive.dart';

/// App bar content: icon, [title], and theme toggle button that invokes [onChanged].
/// [isDark] drives the icon (sun vs moon) and is toggled when the button is pressed.
class CustomAppBar extends StatefulWidget {
  const CustomAppBar({
    required this.title,
    required this.onChanged,
    required this.isDark,
    super.key,
  });
  final String title;
  final bool isDark;
  final ValueChanged<bool> onChanged;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool isDark;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Padding(
      padding: r.appBarPadding,
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
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: r.appBarTitleSize,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            onPressed: () {
              widget.onChanged(!widget.isDark);
            },
            iconSize: r.iconSizeMedium,
            icon: Icon(widget.isDark ? Icons.dark_mode : Icons.sunny),
            color: colors.onPrimary,
          ),
        ],
      ),
    );
  }
}
