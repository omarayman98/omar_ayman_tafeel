import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/api_constants.dart';

dynamic getRequestBody(String requestBody) {
  return requestBody;
}

Future<Response> getCallService(String? url) async {
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader: 'Bearer $headerToken',
  };

  try {
    Dio dio = Dio();
    final response = await dio.get(
      ApiConstants.baseUrl + url!,
      options: Options(headers: headers),
      data: getRequestBody(url),
    );


    return response;
  } on DioException catch (e) {
    // _parseExceptionAndHandle(e);
    rethrow;
  }
}

Exception parseExceptionAndHandle(DioException error) {
  var errorMessageObj = mapError(error);
  if (DioExceptionType.receiveTimeout == error.type ||
      DioExceptionType.connectionTimeout == error.type) {
    return TimeoutException("Network Error");
  } else if (DioExceptionType.badResponse == error.type) {
    log(errorMessageObj['message']!);
    return Exception(errorMessageObj['message']);
  } else if (DioExceptionType.unknown == error.type) {
    if (error.message!.contains('SocketException')) {
      throw const SocketException("No Internet Connection");
    }
  } else {
    return Exception(errorMessageObj['message']);
  }
  return Exception(errorMessageObj['message']);
}

Map<String, String> Function(Object) mapError = (Object error) {
  if (error is DioException) {
    var errorString = jsonDecode(error.response.toString());
    if (error.response?.statusCode != null) {
      switch (error.response!.statusCode) {
        case 403:
          var message = errorString['message'];
          return {"message": message ?? "Wrong Credentials!"};
        case 401:
          var message = errorString['message'];
          return {"message": message ?? "You Are Not Allowed!"};
        case 404:
          var message = errorString['message'];
          return {"message": message ?? "Not found!"};
        case 422:
          var message = errorString['message'];
          if (message is Map) {
            return {"message": message.values.toList().first};
          }
          return {"message": errorString['message']};
        case 409:
          return {"message": errorString['message']};

        case 400:
          return {"message": errorString['message']};
      }
    }
  }
  return {"message": "Some Thing Went Wrong"};
};
