abstract class Failure {
  const Failure({this.message});

  final String? message;
}

class ServerFailure extends Failure {
  const ServerFailure({
    this.status,
    this.statusCode,
    super.message,
  });

  final int? statusCode;
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
