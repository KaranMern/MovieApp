import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String> tabs;
  final EdgeInsetsGeometry? labelPadding;
  final void Function(int index)? onTap;

  const CustomTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    this.labelPadding,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return TabBar(
      controller: controller,
      isScrollable: true,
      labelPadding: labelPadding,
      labelColor: colors.onPrimary,
      unselectedLabelColor: colors.onPrimary.withOpacity(0.6),
      labelStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold),
      unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.normal),
      indicatorColor: colors.onPrimary,
      onTap: onTap,
      tabs: tabs.map((text) => Tab(text: text)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}