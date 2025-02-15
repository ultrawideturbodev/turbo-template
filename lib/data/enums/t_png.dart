enum TPng {
  logoDarkMode,
  logoLightMode,
  topHat,
  doveOfPeace,
  date,
  soap,
  shoppingBags;

  String get path {
    switch (this) {
      case TPng.logoDarkMode:
        return 'assets/pngs/logo_dark_mode.png';
      case TPng.logoLightMode:
        return 'assets/pngs/logo_light_mode.png';
      case TPng.topHat:
        return 'assets/pngs/top_hat.png';
      case TPng.doveOfPeace:
        return 'assets/pngs/dove_of_peace.png';
      case TPng.date:
        return 'assets/pngs/date.png';
      case TPng.soap:
        return 'assets/pngs/soap.png';
      case TPng.shoppingBags:
        return 'assets/pngs/shopping_bags.png';
    }
  }
}
