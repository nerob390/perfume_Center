import '../utlis/utlis.dart';

class AppException implements Exception{
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  String toString(){
    return '$_message$_prefix';

  }
}
class InternetException extends AppException{
  InternetException([String ? message ]):super (message, Utils.toastMessageCenter("No Internet"));
}
class SocketException extends AppException{
  SocketException([String ? message ]):super (message, Utils.toastMessageCenter("No Internet"));
}

class RequestTimeOut extends AppException{
  RequestTimeOut([String ? message ]):super (message, 'Request Time Out');
}

class ServerException extends AppException{
  ServerException([String ? message ]):super (message, 'Internet server error');
}

class InvalidUrlException extends AppException{
  InvalidUrlException([String ? message ]):super (message, 'Invalid url');
}

class FetchDataException extends AppException{
  FetchDataException([String ? message ]):super (message, ' ');
}