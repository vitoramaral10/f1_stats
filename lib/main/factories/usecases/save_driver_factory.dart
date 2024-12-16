import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

SaveDriver makeFirebaseSaveDriver() => FirebaseSaveDriver(
      firebase: makeFirebaseAdapter(),
    );
