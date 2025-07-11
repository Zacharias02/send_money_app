sealed class AppConstants {
  // Temporary registered accounts
  static const kTmpEmail = 'john_doe25@email.com';
  static const kTmpPassword = 'P@ssword1234!';

  // Custom error messages
  static const kUnknownError = 'Oops! Something went wrong.';
  static const kNoAccountFound = 'Account not found. Please Try again.';
  static const kSendMoneySuccess = 'Money sent successfully!';
  static const kNoRecordsFound = 'No records found!';

  static final emailRegex = RegExp(
    r"^(?!.*\.\.)(?!.*\.$)(?!^\.)(?!.*-\.)(?!.*\.-)(?=[^@]{1,64}@)[a-zA-Z0-9!#$%&'*+/=?^_`{|}~.-]+(?<!\.)@[a-zA-Z0-9](?!.*--)[a-zA-Z0-9-]*(?<!-)\.[a-zA-Z]{2,}(?:\.[a-zA-Z]{2,})*$",
  );
}
