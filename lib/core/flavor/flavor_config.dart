/// Build flavors for the app: SIT, UAT, and Production.
enum Flavor {
  sit,
  uat,
  prod,
}

/// Central configuration for the current build flavor.
/// Set [appFlavor] from the flavor-specific main (e.g. main_sit.dart).
class FlavorConfig {
  /// Currently active flavor; set before calling the shared main().
  static Flavor? appFlavor;

  /// Display title for the app based on flavor (e.g. "Movie SIT", "Movie").
  static String get title {
    switch (appFlavor) {
      case Flavor.sit:
        return 'Movie SIT';
      case Flavor.uat:
        return 'Movie UAT';
      case Flavor.prod:
        return 'Movie';
      default:
        return 'Movie';
    }
  }

  /// Whether the current flavor is considered a development build.
  /// Used to enable/disable dev tools (e.g. Alice inspector).
  static bool get isDevelopment {
    switch (appFlavor) {
      case Flavor.sit:
        return false;
      case Flavor.uat:
        return false;
      case Flavor.prod:
        return true;
      default:
        return false;
    }
  }
}
