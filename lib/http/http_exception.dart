class CustomApiException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  @override
  String toString() {
    return '$_prefix$_message';
  }

  CustomApiException(this._message, this._prefix);
}

class FetchDataException extends CustomApiException {
  FetchDataException(message) : super(message, '서버 오류가 발생했습니다.');
}

class BadRequestException extends CustomApiException {
  BadRequestException(message) : super(message, '잘못된 요청입니다.');
}

class UnauthorisedException extends CustomApiException {
  UnauthorisedException(message) : super(message, '권한이 없습니다.');
}

class NotfoundException extends CustomApiException {
  NotfoundException(message) : super(message, '404 Not found');
}

class InvalidInputException extends CustomApiException {
  InvalidInputException(message) : super(message, 'Invalid Input');
}
