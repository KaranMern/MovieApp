import 'package:go_router/go_router.dart';
import 'package:sample/features/Movies/presentation/Screens/dashboard.dart';
import 'package:sample/features/Movies/presentation/Screens/detail_screen.dart';

import '../../features/Movies/domain/entities/movie_detail_entity.dart';
import '../network/alice_configuration.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/home",
  navigatorKey: dioProvider.navigatorKey,
  routes: [
    GoRoute(path: "/home", builder: (context, state) => DashboardScreen()),
    GoRoute(
      path: "/DetailScreen",
      builder: (context, state) {
        final result = state.extra as ResultEntity;
        return Detailscreen(result: result);
      },
    ),
  ],
);
