// ignore_for_file: avoid_equals_and_hash_code_on_mutable_classes

abstract class KlashaException implements Exception {
  String get message;

  @override
  bool operator ==(Object other) {
    return other is KlashaException && message == other.message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() {
    return 'KlashaException: $message';
  }
}

abstract class ServerException implements KlashaException {
  @override
  String toString() {
    return '$runtimeType: $message';
  }
}

class TimeoutServerException extends ServerException {
  TimeoutServerException([this.msg = 'connection timeout']);
  final String msg;

  @override
  String get message => msg;
}

class UnexpectedServerException extends ServerException {
  UnexpectedServerException([this.msg = 'An unexpected error occurred']);
  final String msg;

  @override
  String get message => msg;
}

class UnknownServerException extends ServerException {
  @override
  String get message => 'An unknown error occurred';
}

class KlashaServerException extends ServerException {
  KlashaServerException([this.msg = 'An unexpected error occurred']);
  final String msg;

  @override
  String get message => msg;
}

class InvalidArgOrDataException extends KlashaException {
  InvalidArgOrDataException([this.msg = 'error in arguments or data']);
  final String msg;
  @override
  String get message => msg;
}
