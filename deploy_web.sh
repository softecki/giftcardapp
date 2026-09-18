#!/usr/bin/env bash
# Build the Flutter web app, including sqflite worker binaries.
# Used locally and by GitHub Actions (.github/workflows/deploy-web.yml).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if ! command -v flutter >/dev/null 2>&1; then
  echo "error: flutter is not on PATH" >&2
  exit 1
fi

echo "==> Flutter version"
flutter --version

echo "==> Installing dependencies"
flutter pub get

echo "==> Ensuring sqflite web worker binaries (sqflite_sw.js, sqlite3.wasm)"
dart run sqflite_common_ffi_web:setup --force

echo "==> Building Flutter web release"
BUILD_ARGS=(build web --release --no-wasm-dry-run)
if [[ -n "${BASE_HREF:-}" ]]; then
  BUILD_ARGS+=(--base-href "$BASE_HREF")
fi
flutter "${BUILD_ARGS[@]}"

echo "==> Web build ready: $ROOT/build/web"
ls -lh "$ROOT/build/web/sqflite_sw.js" "$ROOT/build/web/sqlite3.wasm"
