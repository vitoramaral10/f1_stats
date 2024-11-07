import 'package:get/get.dart';

import 'factories/factories.dart';

class Routes {
  static const String initial = '/race_dashboard';

  static List<GetPage> get pages => [
        GetPage(
          name: '/',
          page: makeHomePage,
          binding: makeHomeBinding(),
        ),
        GetPage(
          name: '/session',
          page: makeSessionPage,
          binding: makeSessionBinding(),
        ),
        GetPage(
          name: '/race_dashboard',
          page: makeRaceDashboardPage,
          binding: makeRaceDashboardBinding(),
        )
      ];
}
