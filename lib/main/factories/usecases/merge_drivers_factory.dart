import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

MergeDrivers makeVertexAiMergeDrivers() => VertexAiMergeDrivers(
      vertexAi: makeVertexAiAdapter(),
    );
