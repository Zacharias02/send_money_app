# Send Money App

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `v3.32.0`
- Dart SDK `v3.8.0` _(Will be added once Flutter SDK installed)_
- LCOV Installation _(Code Coverage Report & Testing)_
  - [MAC Installation](https://formulae.brew.sh/formula/lcov)
  - [Windows Installation](http://fredgrott.medium.com/lcov-on-windows-7c58dda07080)
- [FVM](https://fvm.app/) _(Optional, if you're handling multiple Flutter projects)_

### Architechture

- [Clean Code Architechture](https://medium.com/ruangguru/an-introduction-to-flutter-clean-architecture-ae00154001b0)
- BLoC powered by [flutter_bloc](https://pub.dev/packages/flutter_bloc) _(State Management)_

### Features

- Authentication 
  - Login
  - Logout
- Wallet
    - Send Money
    - View Transactions

### Project Setup

- Clone `send_money_app` repository to your local machine and rebuild the project.

  ```bash
  git clone https://github.com/PixoPH/send_money_app.git
  cd your_path/send_money_app/

  # This will generate files used by models, assets, classes,
  # and mocks on the project.
  sh scripts/rebuild.sh
  ```

- To set up the fake API, go to https://crudcrud.com and generate a temporary API key. Copy the unique API key from the URL provided:

    ```
    https://crudcrud.com/api/{your-api-key}
    ```

- Then update the `kRestApiKey` value inside `app_constants.dart` with that key.

## Usage
  
- Optionally, you can run this via Dart CLI:

  ```bash
  flutter run
  ```

### Testing

- After you've added your unit tests, you will need to run this to perform testing with code coverage report.

  ```bash
  sh scripts/unit_test.sh
  ```
