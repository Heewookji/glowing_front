enum UserExceptionCode {
  NoData,
}

class UserException implements Exception {
  final UserExceptionCode code;
  final String message;

  UserException({this.code, this.message});

  @override
  String toString() {
    return message;
  }
}
