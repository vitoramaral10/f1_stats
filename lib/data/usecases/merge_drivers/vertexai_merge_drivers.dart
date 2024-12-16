import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../models/models.dart';
import '../../vertex_ai/vertex_ai.dart';

class VertexAiMergeDrivers implements MergeDrivers {
  final VertexAiClient vertexAi;

  VertexAiMergeDrivers({
    required this.vertexAi,
  });

  @override
  Future<DriverEntity> call(List<DriverEntity> drivers) async {
    try {
      final data = await vertexAi.run(
        "Mescle os pilotos em um JSON com as melhores informações: ${drivers.map((driver) => driver.toJson()).toList()}.",
        responseSchema: VertexAiDriverModel.schema,
      );

      return VertexAiDriverModel.fromJson(data).toEntity();
    } on VertexAiError catch (error) {
      log(error.toString(), name: 'VertexAiMergeDrivers.call');
      throw DomainError.unexpected;
    }
  }
}
