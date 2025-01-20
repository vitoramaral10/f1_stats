import 'package:get/get.dart';

import '../ui/pages/pages.dart';

class Routes {
  static const initial = '/';
  static const meetings = '/meetings';
  static const meeting = '/meeting';

  static List<GetPage> pages = [
    GetPage(
      name: initial,
      page: () => HomePage(),
    ),
    GetPage(
      name: '$meetings/:year',
      page: () => MeetingsPage(),
    ),
    // GetPage(
    //   name: meeting,
    //   page: () => MeetingPage(),
    // ),
  ];
}
