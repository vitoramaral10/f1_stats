import 'package:get/get.dart';

import '../ui/pages/pages.dart';
import 'factories/factories.dart';

class Routes {
  static const initial = '/';
  static const meetings = '/meetings';
  static const sessions = '/sessions';

  static List<GetPage> pages = [
    GetPage(
      name: initial,
      page: () => HomePage(),
    ),
    GetPage(
      name: '$meetings/:year',
      page: () => MeetingsPage(),
      binding: makeMeetingsBindings(),
    ),
    // GetPage(
    //   name: sessions,
    //   page: () => SessionsPage(),
    // ),
  ];
}
