import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

RemoveDriver makeFirebaseRemoveDriver() => FirebaseRemoveDriver(
      firebase: makeFirebaseAdapter(),
    );
