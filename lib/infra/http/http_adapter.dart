import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map? body,
    Map? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    final defaulHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({
        'content-type': 'application/json',
        'accept': 'application/json',
      });

    final jsonBody = body != null ? jsonEncode(body) : null;

    var response = Response('', 500);
    Future<Response>? futureResponse;

    try {
      if (method == 'post') {
        futureResponse =
            client.post(Uri.parse(url), headers: defaulHeaders, body: jsonBody);
      }
      if (method == 'get') {
        futureResponse = client.get(
          Uri.parse(
              '$url?${queryParameters!.entries.map((e) => '${e.key}${e.value}').join('&')}'),
          headers: defaulHeaders,
        );
      }

      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 10));
      }
    } on Exception catch (error) {
      log(error.toString(), name: 'http_adapter.request');
      throw HttpError.serverError;
    }

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else if (response.statusCode == 204) {
      return null;
    } else if (response.statusCode == 400) {
      throw HttpError.badRequest;
    } else if (response.statusCode == 401) {
      throw HttpError.unauthorized;
    } else if (response.statusCode == 403) {
      throw HttpError.forbidden;
    } else if (response.statusCode == 404) {
      throw HttpError.notFound;
    } else {
      throw HttpError.serverError;
    }
  }
}
