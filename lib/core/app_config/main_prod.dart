import 'package:sample/core/flavor/flavor_config.dart';
import 'package:sample/main.dart' as sample;

/// Production flavor entry point. Sets [FlavorConfig.appFlavor] to [Flavor.prod]
/// then delegates to the shared [sample.main].
Future<void> main() async {
  FlavorConfig.appFlavor = Flavor.prod;
  await sample.main();
}
