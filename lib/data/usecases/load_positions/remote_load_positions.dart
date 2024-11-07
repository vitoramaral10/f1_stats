import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadPositions implements LoadPositions {
  final HttpClient httpClient;
  final String url;

  RemoteLoadPositions({required this.httpClient, required this.url});

  @override
  Future<List<PositionEntity>> call({
    required String meetingKey,
    required String sessionKey,
  }) async {
    try {
      Uri urlRequest = Uri(
        scheme: 'https',
        host: url,
        path: '/v1/position',
        queryParameters: {
          'meeting_key': meetingKey.toString(),
          'session_key': sessionKey,
        },
      );
      final response = await httpClient.request(
        url: urlRequest,
        method: HttpMethod.get,
      );
      return response
          .map<PositionEntity>(
              (json) => PositionModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadPositions.call');
      throw DomainError.unexpected;
    }
  }
}
