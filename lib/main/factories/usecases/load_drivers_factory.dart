import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadDrivers makeOpenF1LoadDrivers() => Openf1LoadDrivers(
      httpClient: makeHttpAdapter(),
      url: makeopenf1ApiUrl('drivers'),
    );
