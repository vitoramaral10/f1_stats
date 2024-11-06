import 'package:f1_stats/domain/usecases/load_meetings.dart';

import '../../../data/usecases/usecases.dart';
import '../factories.dart';

LoadMeetings makeRemoteLoadMeetings() => RemoteLoadMeetings(
      httpClient: makePublicHttpClientDecorator(),
      url: makeApiUrl(),
    );
