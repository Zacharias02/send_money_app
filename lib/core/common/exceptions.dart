class LocalStorageException implements Exception {
  const LocalStorageException({
    required this.message,
  });

  final String message;
}

class ServerException implements Exception {
  const ServerException({
    required this.message,
  });

  final String message;
}

class HttpException implements Exception {
  const HttpException({
    this.status,
    this.statusCode,
    this.message,
  });

  final String? status;
  final int? statusCode;
  final String? message;
}
