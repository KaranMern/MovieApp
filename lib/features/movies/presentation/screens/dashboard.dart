import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sample/core/Constants/string_constants.dart';
import 'package:sample/core/constants/key_constants.dart';
import 'package:sample/core/responsive/responsive.dart';
import 'package:sample/features/movies/presentation/Widgets/custom_appbar.dart';
import 'package:sample/features/movies/presentation/Widgets/custom_container.dart';
import 'package:sample/features/movies/presentation/dashboard_providers.dart';
import 'package:sample/features/movies/presentation/widgets/custom_tabbar.dart';

/// Main dashboard: tabbed movie list (Top rated / Popular), pull-to-refresh,
/// and infinite scroll. Uses [dashboardNotifierProvider] for data and
/// [themeProvider] for app bar theme toggle.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  late TabController _tabController;

  /// Debounce timer to avoid calling loadMore too frequently on scroll.
  Timer? _scrollDebounce;

  /// Current filter: [Constants.popular] or [Constants.topRated] (API value).
  String option = Constants.popular;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    scrollController.addListener(_onScroll);
  }

  /// When user scrolls near bottom (within 200px), triggers load more after 300ms debounce.
  void _onScroll() {
    if (!scrollController.hasClients) return;

    if (_scrollDebounce?.isActive ?? false) return;

    _scrollDebounce = Timer(const Duration(milliseconds: 300), () {
      if (scrollController.position.extentAfter < 200) {
        ref.read(dashboardNotifierProvider.notifier).loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollDebounce?.cancel();
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final r = Responsive(context);
    final state = ref.watch(dashboardNotifierProvider);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return Scaffold(
      backgroundColor: colors.tertiary,
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: CustomAppBar(
          title: Constants.appName,
          isDark: isDark,
          onChanged: (_) {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
        bottom: CustomTabBar(
          controller: _tabController,
          tabs: [Constants.filterTopRated, Constants.filterPopular],
          labelPadding: r.tabPadding,
          onTap: (index) async {
            option =
                index == 0 ? Constants.topRated : Constants.popular;

            await ref
                .read(dashboardNotifierProvider.notifier)
                .refreshMovies(filter: option);
          },
        ),
      ),
      body: state.when(
        data: (data) {
          final results = data.results ?? [];

          if (results.isEmpty) {
            return Center(
              child: Text(
                Constants.noData,
                style: theme.textTheme.bodyMedium,
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await ref
                  .read(dashboardNotifierProvider.notifier)
                  .refreshMovies(filter: option);
            },
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(r.gridPadding),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: r.gridCrossAxisCount,
                      childAspectRatio: r.gridAspectRatio,
                      crossAxisSpacing: r.gridSpacing,
                      mainAxisSpacing: r.gridSpacing,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final movie = results[index];

                        return CustomCard(
                          key: KeyConstants.movieCard,
                          posterPath: movie.posterPath ?? '',
                          releaseDate: movie.releaseDate ?? '',
                          title: movie.title ?? 'Untitled',
                          voteAverage: (movie.voteAverage ?? 0.0).toInt(),
                          onPressed: () {
                            context.push('/DetailScreen', extra: movie);
                          },
                        );
                      },
                      childCount: results.length,
                    ),
                  ),
                ),

                /// Placeholder for loading indicator when loading more.
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(
          child: CupertinoActivityIndicator(
            key: KeyConstants.loadingIndicator,
            color: colors.primary,
          ),
        ),
        error: (err, st) => Center(
          child: Text(
            'Error: $err',
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}
