import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  @override
  Future<dynamic> request({
    required Uri url,
    required HttpMethod method,
    Map? body,
    Map? headers,
    useRefreshToken = false,
  }) async {
    try {
      final defaultHeaders = headers?.cast<String, String>() ?? {}
        ..addAll({
          'content-type': 'application/json',
          'accept': 'application/json',
        });
      final jsonBody = body != null ? jsonEncode(body) : null;
      var response = Response('', 500);
      Future<Response>? futureResponse;

      switch (method) {
        case HttpMethod.post:
          futureResponse =
              client.post(url, headers: defaultHeaders, body: jsonBody);
          break;
        case HttpMethod.get:
          futureResponse = client.get(url, headers: defaultHeaders);
          break;
        case HttpMethod.put:
          futureResponse =
              client.put(url, headers: defaultHeaders, body: jsonBody);
          break;
        case HttpMethod.delete:
          futureResponse =
              client.delete(url, headers: defaultHeaders, body: jsonBody);
          break;
        default:
          throw HttpError.methodNotAllowed;
      }

      response = await futureResponse.timeout(const Duration(seconds: 30));

      return _handleResponse(response);
    } on HttpError {
      rethrow;
    } catch (error) {
      log(error.toString(), name: 'HttpAdapter.request');
      throw HttpError.serverError;
    }
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body.isEmpty ? null : jsonDecode(response.body);
      case 201:
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      case 409:
        if (response.body.contains('UserNotConfirmedException')) {
          final jsonDecoded = jsonDecode(response.body);
          return {
            "code": response.statusCode,
            "message": jsonDecoded,
          };
        } else if (response.body.contains('NotAuthorizedException')) {
          throw HttpError.forbidden;
        } else if (response.body.contains('UserNotFoundException')) {
          throw HttpError.notFound;
        } else {
          throw HttpError.conflict;
        }
      default:
        log(response.body, name: 'HttpAdapter._handleResponse');
        throw HttpError.serverError;
    }
  }
}
