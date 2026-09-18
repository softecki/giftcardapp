#!/usr/bin/env bash
# Build the Flutter web app with cache-busting versioning (same flow as safariLandApp).
# Also used by GitHub Actions (.github/workflows/deploy-web.yml).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$ROOT"

if ! command -v flutter >/dev/null 2>&1; then
  echo "error: flutter is not on PATH" >&2
  exit 1
fi

echo "GiftCard web deployment"
echo "=========================================="

echo "==> Flutter version"
flutter --version

echo "==> Installing dependencies"
flutter pub get

echo "==> Ensuring sqflite web worker binaries (sqflite_sw.js, sqlite3.wasm)"
dart run sqflite_common_ffi_web:setup --force

CURRENT_VERSION=$(grep -o '"version": "[^"]*"' web/manifest.json | head -n 1 | cut -d'"' -f4)
echo "Current version: $CURRENT_VERSION"

if [[ -n "${NEW_VERSION:-}" ]]; then
  :
elif [[ -t 0 ]]; then
  read -r -p "Enter new version (current: $CURRENT_VERSION): " NEW_VERSION
else
  NEW_VERSION="$CURRENT_VERSION"
fi

if [[ -z "${NEW_VERSION}" ]]; then
  NEW_VERSION="$CURRENT_VERSION"
fi

echo "Updating version to: $NEW_VERSION"

sed -i.bak "s/\"version\": \"[^\"]*\"/\"version\": \"$NEW_VERSION\"/" web/manifest.json
rm -f web/manifest.json.bak

sed -i.bak "s/name=\"version\" content=\"[^\"]*\"/name=\"version\" content=\"$NEW_VERSION\"/" web/index.html
rm -f web/index.html.bak

BUILD_DATE=$(date +"%Y-%m-%d")
sed -i.bak "s/name=\"build-date\" content=\"[^\"]*\"/name=\"build-date\" content=\"$BUILD_DATE\"/" web/index.html
rm -f web/index.html.bak

echo "==> Building Flutter web release"
# --no-wasm-dry-run is not available on all Flutter SDKs; match safariLandApp flags.
BUILD_ARGS=(build web --release --no-tree-shake-icons)
if [[ -n "${BASE_HREF:-}" ]]; then
  BUILD_ARGS+=(--base-href "$BASE_HREF")
fi
flutter "${BUILD_ARGS[@]}"

echo "==> Web build ready: $ROOT/build/web"
ls -lh "$ROOT/build/web/sqflite_sw.js" "$ROOT/build/web/sqlite3.wasm"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
DEPLOY_DIR="deploy_web_v${NEW_VERSION}_${TIMESTAMP}"

echo "Creating deployment package: $DEPLOY_DIR"
mkdir -p "$DEPLOY_DIR"
cp -r build/web/* "$DEPLOY_DIR/"

cat > "$DEPLOY_DIR/deployment_info.txt" << EOF
GiftCard Web Deployment
================================
Version: $NEW_VERSION
Deployed: $(date)
Build: $TIMESTAMP
Flutter Version: $(flutter --version | head -n 1)
EOF

echo "Deployment package created: $DEPLOY_DIR"
ls -la "$DEPLOY_DIR" | head -n 20

echo ""
echo "Next steps:"
echo "1. Upload the contents of '$DEPLOY_DIR' (or build/web) to your web server"
echo "2. Set Cache-Control for HTML: no-cache, no-store, must-revalidate"
echo "3. Set Cache-Control for JS/CSS: max-age=31536000"
echo ""
echo "Deployment script completed."
