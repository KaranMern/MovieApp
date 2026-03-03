import '../flavor/flavor_config.dart';
import 'package:sample/main.dart' as sample;

Future<void> main() async {
  FlavorConfig.appFlavor = Flavor.sit;
  await sample.main();
}
