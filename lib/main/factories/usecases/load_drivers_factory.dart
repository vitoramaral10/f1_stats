import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadDrivers makeFirebaseLoadDrivers() => FirebaseLoadDrivers(
      firebaseClient: makeFirebaseClient(),
    );
