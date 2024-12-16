import 'dart:developer';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../http/http.dart';
import '../../models/models.dart';

class Openf1LoadDrivers implements LoadDrivers {
  final String url;
  final HttpClient httpClient;

  Openf1LoadDrivers({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<List<DriverEntity>> call() async {
    try {
      final data = await httpClient.request(url: url, method: 'get');
      return data
          .map<DriverEntity>(
              (json) => Openf1DriverModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      log(error.toString(), name: 'Openf1LoadDrivers.call.http_error');

      throw DomainError.unexpected;
    } catch (error) {
      log(error.toString(), name: 'Openf1LoadDrivers.call.error');
      throw DomainError.unexpected;
    }
  }
}
