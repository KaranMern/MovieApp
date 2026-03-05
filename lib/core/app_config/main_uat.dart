import 'package:sample/core/flavor/flavor_config.dart';
import 'package:sample/main.dart' as sample;

/// UAT (User Acceptance Test) flavor entry point. Sets [FlavorConfig.appFlavor]
/// to [Flavor.uat] then delegates to the shared [sample.main].
Future<void> main() async {
  FlavorConfig.appFlavor = Flavor.uat;
  await sample.main();
}
