abstract class Failure {
  const Failure({this.message});

  final String? message;
}

class APIFailure extends Failure {
  const APIFailure({
    this.code,
    this.statusCode,
    this.status,
    super.message,
  });

  final int? code;
  final String? statusCode;
  final String? status;
}

class NoDataFoundFailure extends Failure {
  const NoDataFoundFailure({super.message});
}

class LocalStorageFailure extends Failure {
  const LocalStorageFailure({super.message});
}

class UnknownFailure extends Failure {
  const UnknownFailure({super.message});
}
