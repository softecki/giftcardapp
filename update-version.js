// Version Update Script for Malipo Agent PWA
// Run this script to update the version in index.html and manifest.json

const fs = require('fs');
const path = require('path');

function updateVersion(newVersion) {
  const buildDate = new Date().toISOString().split('T')[0];
  
  // Update index.html
  const indexPath = path.join(__dirname, 'index.html');
  let indexContent = fs.readFileSync(indexPath, 'utf8');
  
  indexContent = indexContent.replace(
    /<meta name="version" content="[^"]*">/,
    `<meta name="version" content="${newVersion}">`
  );
  
  indexContent = indexContent.replace(
    /<meta name="build-date" content="[^"]*">/,
    `<meta name="build-date" content="${buildDate}">`
  );
  
  fs.writeFileSync(indexPath, indexContent);
  console.log(`Updated index.html with version ${newVersion}`);
  
  // Update manifest.json
  const manifestPath = path.join(__dirname, 'manifest.json');
  const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));
  
  manifest.version = newVersion;
  
  fs.writeFileSync(manifestPath, JSON.stringify(manifest, null, 4));
  console.log(`Updated manifest.json with version ${newVersion}`);
  
  // Update service worker
  const swPath = path.join(__dirname, 'sw.js');
  let swContent = fs.readFileSync(swPath, 'utf8');
  
  swContent = swContent.replace(
    /const CACHE_NAME = '[^']*';/,
    `const CACHE_NAME = 'malipo-agent-v${newVersion}';`
  );
  
  fs.writeFileSync(swPath, swContent);
  console.log(`Updated sw.js with version ${newVersion}`);
  
  console.log(`\n✅ Version updated to ${newVersion} (${buildDate})`);
  console.log('📱 PWA will now prompt users to update when they visit the app');
}

// Get version from command line argument
const newVersion = process.argv[2];

if (!newVersion) {
  console.log('Usage: node update-version.js <version>');
  console.log('Example: node update-version.js 1.0.1');
  process.exit(1);
}

// Validate version format (semantic versioning)
const versionRegex = /^\d+\.\d+\.\d+$/;
if (!versionRegex.test(newVersion)) {
  console.log('❌ Invalid version format. Use semantic versioning (e.g., 1.0.1)');
  process.exit(1);
}

updateVersion(newVersion);
