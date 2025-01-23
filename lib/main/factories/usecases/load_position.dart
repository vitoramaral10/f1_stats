import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadPosition makeRemoteLoadPosition() => RemoteLoadPosition(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('position'),
    );
