## Run this script on your terminal to generate files. Ex. sh scripts/rebuild.sh

#!/bin/bash

echo "Starting project rebuilding"

# Check if FVM is activated
if [ -f ".fvm/fvm_config.json" ]; then
  echo "FVM is activated"
  FVM_VERSION=$(fvm flutter --version | grep -o -E '[0-9]+\.[0-9]+\.[0-9]+' | head -n 1)
  TARGET_VERSION=3.32.0
  echo "Parsed FVM version: $FVM_VERSION"
  if [[ "$FVM_VERSION" = "$TARGET_VERSION" ]]; then
    echo "FVM version $TARGET_VERSION is enabled"
    fvm flutter pub get
    fvm dart run build_runner build --delete-conflicting-outputs
  else
    echo "FVM version $TARGET_VERSION is not enabled, current version is $FVM_VERSION"
    echo "Stopping the rebuilding process."
    exit 1
  fi
else
  echo "FVM is not activated"
  flutter pub get
  dart run build_runner build --delete-conflicting-outputs
fi

## Add your custom scripts here

#flutter format lib/

echo "Project rebuilding finished"