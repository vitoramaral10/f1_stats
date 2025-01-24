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
    required int sessionKey,
  }) async {
    try {
      final result = await httpClient.request(
        url: url,
        method: 'get',
        queryParameters: {'session_key=': sessionKey},
      );

      return result!
          .map<DriverEntity>((json) => DriverModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'RemoteLoadDrivers.call');
      throw DomainError.unexpected;
    }
  }
}
