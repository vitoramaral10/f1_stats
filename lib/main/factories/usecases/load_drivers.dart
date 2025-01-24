import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadDrivers makeRemoteLoadDrivers() => RemoteLoadDrivers(
      httpClient: makeHttpAdapter(),
      url: makeApiUrl('drivers'),
    );
