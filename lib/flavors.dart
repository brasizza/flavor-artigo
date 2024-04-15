enum Flavor {
  prod,
  homolog,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.prod:
        return 'MEU APP';
      case Flavor.homolog:
        return 'MEU APP HOMOLOG';
      default:
        return 'title';
    }
  }
}
