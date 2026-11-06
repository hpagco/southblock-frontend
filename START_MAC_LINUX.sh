#!/usr/bin/env bash
cd "$(dirname "$0")"
echo "=== South Block: setup and run ==="
if ! command -v flutter >/dev/null 2>&1; then
  echo "Flutter is not installed. Install it from https://docs.flutter.dev/get-started/install then run this again."
  exit 1
fi
if [ ! -d web ]; then
  echo "Creating web and android folders..."
  flutter create . --platforms=web,android --project-name southblock_app
fi
flutter pub get
read -p "Your email for the photo download (press Enter to skip photos): " EMAIL
if [ -n "$EMAIL" ]; then
  PY=python3; command -v python3 >/dev/null 2>&1 || PY=python
  $PY tools/fetch_commons_photos.py --contact "$EMAIL" --embed
fi
flutter run -d chrome
