import 'package:get/get.dart';

import 'factories/factories.dart';

class Routes {
  static const initial = '/';

  static final pages = [
    GetPage(
      name: initial,
      page: makeHomePage,
    ),
    GetPage(
      name: '/drivers',
      page: makeDriversPage,
      binding: makeGetxDriversBindings(),
    ),
    GetPage(
      name: '/drivers/:driverId',
      page: makeDriverDetailsPage,
      binding: makeGetxDriverDetailsBindings(),
    ),
  ];
}
