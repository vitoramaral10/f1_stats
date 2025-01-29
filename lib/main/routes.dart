import 'package:get/get.dart';

import '../ui/pages/pages.dart';
import 'factories/factories.dart';

abstract class Routes {
  static const initial = '/';
  static const meetings = '/meetings';
  static const sessions = '/sessions';
  static const session = '/session';

  static final List<GetPage> pages = [
    _createPage(
      name: initial,
      page: HomePage(),
    ),
    _createPage(
      name: '$meetings/:year',
      page: MeetingsPage(),
      binding: makeMeetingsBindings(),
    ),
    _createPage(
      name: '$sessions/:meetingKey',
      page: SessionsPage(),
      binding: makeSessionsBindings(),
    ),
    _createPage(
      name: session,
      page: SessionPage(),
      binding: makeSessionBindings(),
    ),
  ];

  static GetPage _createPage({
    required String name,
    required dynamic page,
    Bindings? binding,
  }) {
    return GetPage(
      name: name,
      page: () => page,
      binding: binding,
    );
  }
}
