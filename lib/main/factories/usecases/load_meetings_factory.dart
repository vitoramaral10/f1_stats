import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadMeetings makeRemoteLoadMeetings() => RemoteLoadMeetings(
      httpClient: makePublicHttpClientDecorator(),
      url: makeApiUrl(),
    );
