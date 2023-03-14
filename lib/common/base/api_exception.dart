class ApiException implements Exception {
  final String _message;
  final String _prefix;

  ApiException(this._message, this._prefix);

  String get prefix => _prefix;
  String get message => _message;

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException(String message)
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiException {
  BadRequestException(message) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException(String message) : super(message, "Unauthorized: ");
}

class InvalidInputException extends ApiException {
  InvalidInputException(String message) : super(message, "Invalid Input: ");
}

class UnknowException extends ApiException {
  UnknowException(String message) : super(message, "Unknow error: ");
}
