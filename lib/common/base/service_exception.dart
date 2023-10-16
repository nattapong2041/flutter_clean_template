import 'base_response.dart';

sealed class ServiceException<T> implements Exception {
  final String _message;
  final T? _data;
  ServiceException({
    required String message,
    T? data,
  })  : _message = message,
        _data = data;

  String get message => _message;
  T? get data => _data;

  @override
  String toString() {
    return "$_message ${data == null ? '' : data.toString()}";
  }
}

final class APIException<T> extends ServiceException<T> {
  final StatusCode _statusCode;

  APIException({
    required StatusCode statusCode,
    required String message,
    T? data,
  })  : _statusCode = statusCode,
        super(message: message, data: data);

  StatusCode get statusCode => _statusCode;

  @override
  String toString() {
    return "$_statusCode $_message ${data == null ? '' : data.toString()}";
  }
}

final class ServerException<T> extends ServiceException<T> {
  ServerException({
    T? data,
  }) : super(message: "Error while connect to server", data: data);
}

final class DataParsingException<T> extends ServiceException<T> {
  DataParsingException({
    T? data,
  }) : super(message: "Error while parsing data", data: data);
}

final class NoInternetConnectionException<T> extends ServiceException<T> {
  NoInternetConnectionException({
    T? data,
  }) : super(message: "No internet connection", data: data);
}
