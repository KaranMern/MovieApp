import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/core/network/dio_provider.dart';
import 'package:sample/features/movies/data/datasources/remote_data_source.dart';
import 'package:sample/features/movies/domain/entities/movie_detail_entity.dart';
import 'package:sample/features/movies/domain/repositories/get_movies_repository_impl.dart';
import 'package:sample/features/movies/providers/dashboard_notifier.dart';
import 'package:sample/features/movies/providers/theme_notifier.dart';

/// Provides [DashboardDataSource] implementation using [dioProvider].
final dashboardDatasourceProvider = Provider<DashboardDataSource>((ref) {
  return MoviesDataSource(
    apidio: ref.watch(dioProvider),
  );
});

/// Provides [DashboardRepository] implementation using [dashboardDatasourceProvider].
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final datasource = ref.watch(dashboardDatasourceProvider);
  return DashboardRepositoryImpl(datasource);
});

/// Async state for movie list: [MovieEntity] or loading/error.
final dashboardNotifierProvider =
    AsyncNotifierProvider<DashboardNotifier, MovieEntity>(() {
  return DashboardNotifier();
});

/// Current theme mode (light/dark); used by [MyApp].
final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

/// Stream of connectivity changes; used to show connection status toasts.
final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map(
    (event) => event.isNotEmpty ? event.first : ConnectivityResult.none,
  );
});
