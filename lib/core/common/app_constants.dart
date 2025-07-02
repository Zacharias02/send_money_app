sealed class AppConstants {
  // The key used for retrieving user data from local storage.
  // While not recommended for production authentication, this is quite acceptable for simulating the auth flow.
  static const kAuthLoginKey = 'MAeSRYBDxqteSrFSqsCX';

  // Temporary registered accounts
  static const kTmpEmail = 'john_doe25@email.com';
  static const kTmpPassword = 'P@ssword1234!';

  // Custom error messages
  static const kUnknownError = 'Oops! Something went wrong.';
  static const kNoAccountFound = 'Account not found. Please Try again.';

  static final emailRegex = RegExp(
    r"^(?!.*\.\.)(?!.*\.$)(?!^\.)(?!.*-\.)(?!.*\.-)(?=[^@]{1,64}@)[a-zA-Z0-9!#$%&'*+/=?^_`{|}~.-]+(?<!\.)@[a-zA-Z0-9](?!.*--)[a-zA-Z0-9-]*(?<!-)\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})*$",
  );
}
