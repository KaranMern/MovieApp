import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Constants/api_constants.dart';
import '../../../../core/Constants/string_constants.dart';
import '../../../../core/constants/key_constants.dart';
import '../../../../core/network/secure_storage.dart';
import '../../../../core/responsive/responsive.dart';
import '../dashboard_provider.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/custom_container.dart';
import '../widgets/custom_tabbar.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  bool isDark = false;
  String option = Constants.popular;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    scrollController.addListener(_onScroll);
    _initialize();
  }

  Future<void> _initialize() async {
    await SecureStorage().setValue(Constants.apiToken, ApiConstants.token);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      ref.read(dashboardNotifierProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
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

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.primary,
        title: CustomAppBar(
          title: Constants.appName,
          isDark: isDark,
          onChanged: (val) {
            setState(() => isDark = val);
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
        bottom: CustomTabBar(
          controller: _tabController,
          tabs: [Constants.Toprated, Constants.Popular],
          labelPadding: r.tabPadding,
          onTap: (index) async {
            option = index == 0
                ? Constants.topRated
                : Constants.popular;

            await ref
                .read(dashboardNotifierProvider.notifier)
                .refreshMovies(filter: option);
          },
        ),
      ),
      body: state.when(
        data: (data) {
          if (data.results == null || data.results!.isEmpty) {
            return Center(
              child: Text(
                Constants.noData,
                style: theme.textTheme.bodyMedium,
              ),
            );
          }

          final results = data.results ?? [];

          return RefreshIndicator(
            key: KeyConstants.refreshIndicator,
            onRefresh: () async {
              await ref
                  .read(dashboardNotifierProvider.notifier)
                  .refreshMovies(filter: option);
            },
            child: GridView.builder(
              key: KeyConstants.movieGrid,
              padding: EdgeInsets.all(r.gridPadding),
              controller: scrollController,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: r.gridCrossAxisCount,
                childAspectRatio: r.gridAspectRatio,
                crossAxisSpacing: r.gridSpacing,
                mainAxisSpacing: r.gridSpacing,
              ),
              itemCount: results.length + 1,
              itemBuilder: (context, index) {
                if (index == results.length) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }

                final movie = results[index];

                return CustomCard(
                  key: KeyConstants.movieCard,
                  posterPath: movie.posterPath!,
                  releaseDate: movie.releaseDate!,
                  title: movie.title!,
                  voteAverage: movie.voteAverage!.toInt(),
                  onPressed: () {
                    context.push("/DetailScreen", extra: movie);
                  },
                );
              },
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
            "Error: $err",
            style: theme.textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}