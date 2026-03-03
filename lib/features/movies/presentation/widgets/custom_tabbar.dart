import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final TabController controller;
  final List<String> tabs;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle Function(Color color, {FontWeight? weight})?
  labelStyleBuilder;
  final EdgeInsetsGeometry? labelPadding;
  final Color indicatorColor;
  final void Function(int index)? onTap;

  const CustomTabBar({
    Key? key,
    required this.controller,
    required this.tabs,
    required this.labelColor,
    required this.unselectedLabelColor,
    this.labelStyleBuilder,
    this.labelPadding,
    required this.indicatorColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      labelPadding: labelPadding,
      labelColor: labelColor,
      labelStyle: labelStyleBuilder?.call(labelColor),
      unselectedLabelStyle: labelStyleBuilder?.call(
        unselectedLabelColor,
        weight: FontWeight.normal,
      ),
      unselectedLabelColor: unselectedLabelColor,
      indicatorColor: indicatorColor,
      onTap: onTap,
      tabs: tabs.map((text) => Tab(text: text)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
