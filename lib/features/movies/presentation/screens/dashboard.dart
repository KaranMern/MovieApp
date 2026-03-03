import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/Constants/api_constants.dart';
import '../../../../core/Constants/string_constants.dart';
import '../../../../core/constants/key_constants.dart';
import '../../../../core/network/secure_storage.dart';
import '../../../../core/responsive/responsive.dart';
import '../../domain/entities/movie_detail_entity.dart';
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
  int page = 1;
  bool isDark = false;
  String option = "popular";
  late TabController _tabController;
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchData());
    _tabController = TabController(length: 2, vsync: this);
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      setState(() => page++);
      fetchData();
    }
  }

  Future<void> fetchData() async {
    await SecureStorage().setValue(Constants.apiToken, ApiConstants.token);
    await ref
        .read(dashboardNotifierProvider.notifier)
        .fetchProducts(page: page, filter: option);
  }

  bool _hasMorePages(MovieEntity data) {
    if (data.totalPages == null || data.page == null) return false;
    return data.page! < data.totalPages!;
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
    final colors = Theme.of(context).colorScheme;

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
          labelColor: colors.onPrimary,
          unselectedLabelColor: colors.onPrimary.withOpacity(0.5),
          labelStyleBuilder: (color, {weight}) => TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: weight ?? FontWeight.bold,
          ),
          labelPadding: r.tabPadding,
          indicatorColor: colors.onPrimary,
          onTap: (index) async {
            setState(() {
              page = 1;
              option = index == 1 ? Constants.topRated : Constants.popular;
            });
            await fetchData();
          },
        ),
      ),
      body: state.when(
        data: (data) {
          if (data.results == null || data.results!.isEmpty) {
            return Center(
              child: Text(
                Constants.noData,
                style: r.bodyStyle(colors.onBackground),
              ),
            );
          }
          return RefreshIndicator(
            key: KeyConstants.refreshIndicator,
            onRefresh: () async {
              setState(() => page = 1);
              ref.invalidate(dashboardNotifierProvider);
              await fetchData();
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
              itemCount: _hasMorePages(data)
                  ? data.results!.length + 1
                  : data.results!.length,
              itemBuilder: (context, index) {
                final results = data.results ?? [];
                if (_hasMorePages(data) && index == results.length) {
                  return Center(
                    child: CupertinoActivityIndicator(color: colors.primary),
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
          child: Text("Error: $err", style: r.bodyStyle(colors.onBackground)),
        ),
      ),
    );
  }
}
