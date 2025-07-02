class LocalStorageException implements Exception {
  const LocalStorageException({
    required this.message,
  });

  final String message;
}
