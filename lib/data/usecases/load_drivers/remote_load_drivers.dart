import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class RemoteLoadDrivers implements LoadDrivers {
  final HttpClient httpClient;
  final String url;

  RemoteLoadDrivers({required this.httpClient, required this.url});

  @override
  Future<List<DriverEntity>> call({
    required String meetingKey,
    String? sessionKey,
  }) async {
    try {
      Uri urlRequest = Uri(
        scheme: 'https',
        host: url,
        path: '/v1/drivers',
        queryParameters: {
          'meeting_key': meetingKey.toString(),
          if (sessionKey != null) 'session_key': sessionKey,
        },
      );
      final response = await httpClient.request(
        url: urlRequest,
        method: HttpMethod.get,
      );
      return response
          .map<DriverEntity>((json) => DriverModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadDrivers.call');
      throw DomainError.unexpected;
    }
  }
}
