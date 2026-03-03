import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/core/network/secure_storage.dart';
import '../../../core/network/alice_configuration.dart';
import '../providers/dashboard_notifier.dart';
import '../providers/theme_notifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/datasources/remote_data_source.dart';
import '../domain/entities/movie_detail_entity.dart';
import '../domain/repositories/get_movies_repository_impl.dart';

final dashboardDatasourceProvider = Provider<DashboardDataSource>((ref) {
  return MoviesDataSource(
    Apidio: dioProvider.dio,
    secureStorageBase: SecureStorage(),
  );
});

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final datasource = ref.watch(dashboardDatasourceProvider);
  return DashboardRepositoryImpl(datasource);
});

final dashboardNotifierProvider =
    AsyncNotifierProvider<DashboardNotifier, MovieEntity>(() {
      return DashboardNotifier();
    });
final themeProvider = NotifierProvider<Themenotifier, ThemeMode>(() {
  return Themenotifier();
});

final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((event) => event.first);
});
