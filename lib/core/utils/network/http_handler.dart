import 'dart:async';
import 'dart:convert';
import 'dart:developer' show log;
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class HttpHandler {
  final String logName = 'HttpHandler';
  static HttpHandler? _instance;
  static http.Client? _client;

  final String? baseUrl;

  HttpHandler._internal() : baseUrl = dotenv.env['API_URL'];

  factory HttpHandler() {
    _instance ??= HttpHandler._internal();
    _client ??= http.Client();
    return _instance!;
  }

  http.Client get client => _client!;

  // Close client when done (call on app dispose)
  static void dispose() {
    _client?.close();
    _client = null;
    _instance = null;
  }

  // ============================================================
  // HEADERS
  // ============================================================

  Map<String, String> _defaultHeaders() {
    return {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };
  }

  Map<String, String> _authHeaders(String token) {
    return {
      ..._defaultHeaders(),
      HttpHeaders.authorizationHeader: 'Bearer $token',
    };
  }

  // ============================================================
  // GET REQUESTS
  // ============================================================

  Future<HttpResponse> get(
    String endpoint, {
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.get(uri, headers: _defaultHeaders());
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  Future<HttpResponse> getWithAuth(
    String endpoint, {
    required String token,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.get(uri, headers: _authHeaders(token));
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  // ============================================================
  // POST REQUESTS
  // ============================================================

  Future<HttpResponse> post(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);

      final response = await client.post(
        uri,
        headers: _defaultHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  Future<HttpResponse> postWithAuth(
    String endpoint, {
    required String token,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);

      final response = await client.post(
        uri,
        headers: _authHeaders(token),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  // ============================================================
  // PUT REQUESTS
  // ============================================================

  Future<HttpResponse> put(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.put(
        uri,
        headers: _defaultHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  Future<HttpResponse> putWithAuth(
    String endpoint, {
    required String token,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.put(
        uri,
        headers: _authHeaders(token),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  // ============================================================
  // PATCH REQUESTS
  // ============================================================

  Future<HttpResponse> patch(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.patch(
        uri,
        headers: _defaultHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  Future<HttpResponse> patchWithAuth(
    String endpoint, {
    required String token,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.patch(
        uri,
        headers: _authHeaders(token),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  // ============================================================
  // DELETE REQUESTS
  // ============================================================

  Future<HttpResponse> delete(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.delete(
        uri,
        headers: _defaultHeaders(),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  Future<HttpResponse> deleteWithAuth(
    String endpoint, {
    required String token,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    return _handleRequest(() async {
      final uri = _buildUri(endpoint, queryParams);
      final response = await client.delete(
        uri,
        headers: _authHeaders(token),
        body: body != null ? jsonEncode(body) : null,
      );
      log('Request: ${uri.toString()}', name: '$logName| $endpoint');
      log(
        'Request body: ${body != null ? jsonEncode(body) : null}',
        name: '$logName| $endpoint',
      );
      log(
        'Response: ${jsonDecode(response.body)}',
        name: '$logName| $endpoint',
      );
      return response;
    });
  }

  // ============================================================
  // MULTIPART REQUESTS (File Upload)
  // ============================================================

  Future<HttpResponse> uploadFile(
    String endpoint, {
    required String token,
    required String filePath,
    required String fieldName,
    Map<String, String>? additionalFields,
  }) async {
    try {
      final uri = _buildUri(endpoint, null);
      final request = http.MultipartRequest('POST', uri);

      request.headers.addAll(_authHeaders(token));
      request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));

      if (additionalFields != null) {
        request.fields.addAll(additionalFields);
      }

      final streamedResponse = await client.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      return _parseResponse(response);
    } on SocketException {
      return HttpResponse.error(HttpError.noInternet);
    } on TimeoutException {
      return HttpResponse.error(HttpError.timeout);
    } catch (e) {
      return HttpResponse.error(HttpError.unknown, message: e.toString());
    }
  }

  // ============================================================
  // HELPERS
  // ============================================================

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParams) {
    final url = '$baseUrl$endpoint';

    if (queryParams != null && queryParams.isNotEmpty) {
      final stringParams = queryParams.map(
        (key, value) => MapEntry(key, value.toString()),
      );
      return Uri.parse(url).replace(queryParameters: stringParams);
    }

    return Uri.parse(url);
  }

  Future<HttpResponse> _handleRequest(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request().timeout(const Duration(seconds: 30));
      return _parseResponse(response);
    } on SocketException {
      return HttpResponse.error(HttpError.noInternet);
    } on TimeoutException {
      return HttpResponse.error(HttpError.timeout);
    } on http.ClientException catch (e) {
      return HttpResponse.error(HttpError.clientError, message: e.message);
    } on FormatException catch (e) {
      return HttpResponse.error(HttpError.formatError, message: e.message);
    } catch (e) {
      return HttpResponse.error(HttpError.unknown, message: e.toString());
    }
  }

  HttpResponse _parseResponse(http.Response response) {
    dynamic body;

    try {
      if (response.body.isNotEmpty) {
        body = jsonDecode(response.body);
      }
    } catch (_) {
      body = response.body;
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return HttpResponse.success(body, response.statusCode);
      case 204:
        return HttpResponse.success(null, response.statusCode);
      case 400:
        return HttpResponse.error(
          HttpError.badRequest,
          statusCode: 400,
          body: body,
        );
      case 401:
        return HttpResponse.error(
          HttpError.unauthorized,
          statusCode: 401,
          body: body,
        );
      case 403:
        return HttpResponse.error(
          HttpError.forbidden,
          statusCode: 403,
          body: body,
        );
      case 404:
        return HttpResponse.error(
          HttpError.notFound,
          statusCode: 404,
          body: body,
        );
      case 409:
        return HttpResponse.error(
          HttpError.conflict,
          statusCode: 409,
          body: body,
        );
      case 422:
        return HttpResponse.error(
          HttpError.unprocessable,
          statusCode: 422,
          body: body,
        );
      case 429:
        return HttpResponse.error(
          HttpError.tooManyRequests,
          statusCode: 429,
          body: body,
        );
      case 500:
      case 501:
      case 502:
      case 503:
        return HttpResponse.error(
          HttpError.serverError,
          statusCode: response.statusCode,
          body: body,
        );
      default:
        return HttpResponse.error(
          HttpError.unknown,
          statusCode: response.statusCode,
          body: body,
        );
    }
  }
}

// ============================================================
// RESPONSE MODEL
// ============================================================

class HttpResponse {
  final bool isSuccess;
  final dynamic data;
  final int? statusCode;
  final HttpError? error;
  final String? message;

  HttpResponse._({
    required this.isSuccess,
    this.data,
    this.statusCode,
    this.error,
    this.message,
  });

  factory HttpResponse.success(dynamic data, int statusCode) {
    return HttpResponse._(isSuccess: true, data: data, statusCode: statusCode);
  }

  factory HttpResponse.error(
    HttpError error, {
    int? statusCode,
    dynamic body,
    String? message,
  }) {
    return HttpResponse._(
      isSuccess: false,
      error: error,
      statusCode: statusCode,
      data: body,
      message: message ?? error.defaultMessage,
    );
  }

  T? bodyAs<T>() => data as T?;

  @override
  String toString() {
    return 'HttpResponse(isSuccess: $isSuccess, statusCode: $statusCode, '
        'error: $error, message: $message)';
  }
}

// ============================================================
// ERROR TYPES
// ============================================================

enum HttpError {
  noInternet('No internet connection'),
  timeout('Request timed out'),
  badRequest('Bad request'),
  unauthorized('Unauthorized'),
  forbidden('Access forbidden'),
  notFound('Resource not found'),
  conflict('Conflict occurred'),
  unprocessable('Unprocessable entity'),
  tooManyRequests('Too many requests'),
  serverError('Server error'),
  clientError('Client error'),
  formatError('Response format error'),
  unknown('Unknown error');

  final String defaultMessage;
  const HttpError(this.defaultMessage);
}
