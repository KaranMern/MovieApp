import 'package:flutter_alice/alice.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample/core/flavor/flavor_config.dart';

/// Provides [Alice] for SIT flavor only; null otherwise. Used by [dio_provider]
/// to attach the Alice Dio interceptor for network inspection (e.g. on device shake).
final aliceProvider = Provider<Alice?>((ref) {
  if (FlavorConfig.appFlavor == Flavor.sit) {
    return Alice(
      showInspectorOnShake: true,
      darkTheme: true,
    );
  }
  return null;
});
