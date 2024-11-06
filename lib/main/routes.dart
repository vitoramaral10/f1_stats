import 'package:get/get.dart';

import 'factories/factories.dart';

class Routes {
  static const String initial = '/';

  static List<GetPage> get pages => [
        GetPage(
          name: '/',
          page: makeHomePage,
          binding: makeHomeBinding(),
        )
      ];
}
