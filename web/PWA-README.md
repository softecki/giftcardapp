# Malipo Agent PWA Setup & Update Guide

## 🚀 Progressive Web App Features

This PWA supports installation on:
- **Android** (Chrome, Firefox, Samsung Internet)
- **iOS** (Safari, Chrome)
- **Desktop** (Chrome, Edge, Firefox)

## 📱 Installation Instructions

### Android Users
1. Open the app in Chrome browser
2. Tap the "Install" button when prompted
3. Or tap the menu (⋮) → "Add to Home screen"

### iOS Users
1. Open the app in Safari browser
2. Tap the "Install" button when prompted
3. Follow the instructions to "Add to Home Screen"
4. Or manually: Tap Share (□↗) → "Add to Home Screen"

## 🔄 Update Management

### Automatic Updates
- The app automatically checks for updates every 30 minutes
- Users will see a green notification banner when updates are available
- Users can choose to update immediately or dismiss the notification

### Manual Version Updates
To update the app version:

1. **Update version in code:**
   ```bash
   node update-version.js 1.0.1
   ```

2. **Build and deploy:**
   ```bash
   flutter build web --release
   ```

3. **Deploy to your server**

### Version Update Process
1. The service worker detects new files
2. Shows update notification to users
3. Users can update immediately or continue with current version
4. Update applies on next app restart

## 🛠️ Technical Details

### Files Modified for PWA Support
- `index.html` - PWA meta tags, install prompts, update notifications
- `manifest.json` - App metadata, icons, display settings
- `sw.js` - Service worker for caching and updates
- `update-version.js` - Version management script

### Key Features
- ✅ Install prompts for Android & iOS
- ✅ Automatic update detection
- ✅ Offline caching
- ✅ Push notification support (ready)
- ✅ Version management
- ✅ Cross-platform compatibility

### Browser Support
- **Chrome/Edge**: Full PWA support with install prompts
- **Safari (iOS)**: Custom install instructions
- **Firefox**: Basic PWA support
- **Samsung Internet**: Full PWA support

## 📊 Monitoring

### Console Logs
The app logs useful information:
- Version and build date
- Platform detection (iOS/Android/Desktop)
- Browser detection
- Installation status
- Update notifications

### User Analytics
Track PWA adoption:
- Install prompts shown
- Installation success rate
- Update acceptance rate
- Platform distribution

## 🔧 Customization

### Update Notification Timing
Modify in `index.html`:
```javascript
// Check for updates every 30 minutes
setInterval(checkForUpdates, 30 * 60 * 1000);
```

### Install Prompt Delay
Modify in `index.html`:
```javascript
// Show install prompt after 2 seconds
setTimeout(() => installBanner.classList.add('show'), 2000);
```

### Cache Strategy
Modify in `sw.js`:
```javascript
const CACHE_NAME = 'malipo-agent-v1.0.0';
const urlsToCache = [
  // Add/remove files to cache
];
```

## 🚨 Troubleshooting

### Common Issues
1. **Install prompt not showing**: Check if app is already installed or dismissed
2. **Updates not detected**: Clear browser cache and reload
3. **iOS install issues**: Ensure using Safari browser
4. **Service worker errors**: Check console for registration errors

### Debug Mode
Enable debug logging by opening browser console and looking for:
- "Malipo Agent v1.0.0" - Version info
- "Service Worker registered successfully" - SW status
- "PWA was installed" - Installation confirmation

## 📈 Best Practices

1. **Version Updates**: Use semantic versioning (1.0.1, 1.1.0, 2.0.0)
2. **Testing**: Test install prompts on real devices
3. **Performance**: Monitor cache hit rates
4. **User Experience**: Don't show install prompts too frequently
5. **Updates**: Provide clear update notifications with benefits

## 🔗 Resources

- [PWA Documentation](https://web.dev/progressive-web-apps/)
- [Service Worker Guide](https://developers.google.com/web/fundamentals/primers/service-workers)
- [Web App Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)
- [Flutter Web PWA](https://flutter.dev/web)
