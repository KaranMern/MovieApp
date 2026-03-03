

enum Flavor {
  sit,
  uat,
  prod,
}

class FlavorConfig {
  static Flavor? appFlavor;

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
