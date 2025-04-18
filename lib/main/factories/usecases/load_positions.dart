import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadPositions makeRemoteLoadPositions() => RemoteLoadPositions(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('position'),
    );
