
class BaseModel {
  int code;
  String message;
  dynamic data;

  bool get isSuccess => code == 200 || code == 201;
  bool get isFailed => !isSuccess;

  BaseModel({
    this.code = 0,
    this.message = '',
    required this.data,
  });
}
