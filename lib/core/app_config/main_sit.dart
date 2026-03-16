import 'package:sample/core/flavor/flavor_config.dart';
import 'package:sample/main.dart' as sample;

/// SIT (System Integration Test) flavor entry point. Sets [FlavorConfig.appFlavor]
/// to [Flavor.sit] then delegates to the shared [sample.main].
Future<void> main() async {
  FlavorConfig.appFlavor = Flavor.sit;
  await sample.main();
}
