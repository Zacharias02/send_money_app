#!/bin/bash
# Generate `coverage/lcov.info` file

# Check if FVM is activated
if [ -f ".fvm/fvm_config.json" ]; then
  echo "FVM is activated"
  FVM_VERSION=$(fvm flutter --version | grep -o -E '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
  TARGET_VERSION=3.32.0
  echo "Parsed FVM version: $FVM_VERSION"
  if [[ "$FVM_VERSION" = "$TARGET_VERSION" ]]; then
    echo "FVM version $TARGET_VERSION is enabled"
    fvm flutter test --coverage
  else
    echo "FVM version $TARGET_VERSION is not enabled, current version is $FVM_VERSION"
    echo "Stop unit test execution."
    exit 1
  fi
else
  echo "FVM is not activated"
  flutter test --coverage
fi

lcov -r coverage/lcov.info \
    'lib/core/di/injector.config.dart' \
    'lib/core/resources/*' \
    'lib/**/*.freezed.dart' \
    'lib/**/*.g.dart' \
    'lib/**/*.chopper.dart' \
    'lib/**/*.gr.dart' \
    'lib/**/*.config.dart' \
-o coverage/lcov.info

# Generate HTML report
# Note: on macOS you need to have lcov installed on your system (`brew install lcov`) to use this:
genhtml coverage/lcov.info -o coverage/html

# Open the report
open coverage/html/index.html