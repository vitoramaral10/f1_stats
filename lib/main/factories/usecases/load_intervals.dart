import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadIntervals makeRemoteLoadIntervals() => RemoteLoadIntervals(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('intervals'),
    );
