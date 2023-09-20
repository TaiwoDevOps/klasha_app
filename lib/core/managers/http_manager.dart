import 'package:dio/dio.dart';
import 'package:klasha_app/core/error/exception.dart';

enum RequestType { get, post, put, patch, delete }

const successCodes = [200, 201, 203, 204];

class HttpManager {
  HttpManager({
    Dio? dio1,
  }) {
    _dio1 = dio1 ?? Dio();
    _dio1.options.baseUrl =
        'https://lb7u7svcm5.execute-api.ap-southeast-1.amazonaws.com/dev';
    _dio1.options.connectTimeout = 30000;
    _dio1.options.receiveTimeout = 30000;
  }
  late Dio _dio1;

  Future get(String endpoint) async {
    return _makeRequest(
      RequestType.get,
      endpoint,
      {},
    );
  }

  Future post(
    String endpoint,
    Map<String, dynamic> data,
  ) {
    return _makeRequest(
      RequestType.post,
      endpoint,
      data,
    );
  }

  Future patch(
    String endpoint,
    dynamic data,
  ) {
    return _makeRequest(
      RequestType.patch,
      endpoint,
      data,
    );
  }

  Future put(
    String endpoint,
    Map<String, dynamic> data,
  ) {
    return _makeRequest(
      RequestType.put,
      endpoint,
      data,
    );
  }

  Future delete(String endpoint) {
    return _makeRequest(
      RequestType.delete,
      endpoint,
      {},
    );
  }

  //Data parameter should be dynamic because it may accept
  //other variables other than map
  Future _makeRequest(
    RequestType type,
    String endpoint,
    dynamic data,
  ) async {
    try {
      late Response response;
      switch (type) {
        case RequestType.get:
          response = await _dio1.get(endpoint);

          break;
        case RequestType.post:
          response = await _dio1.post(endpoint, data: data);
          break;
        case RequestType.put:
          response = await _dio1.put(endpoint, data: data);
          break;
        case RequestType.patch:
          response = await _dio1.patch(endpoint, data: data);
          break;
        case RequestType.delete:
          response = await _dio1.delete(endpoint);
          break;
        // ignore: no_default_cases
        default:
          throw InvalidArgOrDataException();
      }
      if (successCodes.contains(response.statusCode)) {
        return response.data;
      }
      throw KlashaServerException(_handleException(response.data));
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      }
      if (e is DioError) {
        if (e.type == DioErrorType.connectTimeout ||
            e.type == DioErrorType.receiveTimeout) {
          throw TimeoutServerException();
        }
        if (e is FormatException) {
          throw InvalidArgOrDataException();
        }
        if (e.response != null) {
          throw KlashaServerException(_handleException(e.response?.data));
        }
      }
      throw UnexpectedServerException();
    }
  }

  String _handleException(dynamic err) {
    if (err != null && err.toString().isNotEmpty) {
      // ignore: avoid_dynamic_calls
      if (err['message'] != null) {
        // ignore: avoid_dynamic_calls
        return err['message'].toString();
      }
      // ignore: avoid_dynamic_calls
      if (err['error'] != null) {
        // ignore: avoid_dynamic_calls
        return err['error'].toString();
      }
    }
    // this colon at the end of the string is used to identify the error in the logs which means that
    // the server returned an error but we couldn't parse it.
    return 'An unexpected error occurred:';
  }
}
