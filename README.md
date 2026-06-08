# Fitness Tracker - Flutter App (Web + Windows + iOS)

## Weight Loss & Toning Monitor: 78kg → 65-68kg by Aug 29

Cross-platform Flutter app with workout monitoring, progress tracking, daily checklists, and push notification reminders. Runs on **Web browsers**, **Windows**, and **iOS**.

---

## 🌐 Platforms

| Platform | Layout | Notifications | Data Storage |
|----------|--------|---------------|--------------|
| **Web (Chrome/Edge/Safari)** | Responsive side nav / bottom nav | Browser Notification API | localStorage |
| **Windows** | Desktop side nav (NavigationRail) | PowerShell toast + timer | SharedPreferences |
| **iOS** | Mobile bottom tabs | flutter_local_notifications | SharedPreferences |

---

## Features

| Feature | Description |
|---------|-------------|
| 📅 Today View | Today's workouts, meals, progress at a glance |
| 📋 Weekly Plan | 7-day tabbed workout + meal breakdown |
| ✅ Daily Checklist | 7 daily habits tracker with streak counter |
| 📊 Progress Tracker | Weight logging, line chart, weekly targets |
| 🔔 Notifications | Automated reminders (workouts, meals, water, sleep) |
| 💰 Budget Display | Daily meal cost tracking (₱100-150 target) |
| 📱 PWA Support | Install as app from browser (Add to Home Screen) |

---

## Quick Start

### 🌐 Web (Recommended for quick access)

```bat
:: Debug with hot reload (opens Chrome)
run_web_debug.bat

:: Build for production
build_web.bat
```

Or manually:
```bash
flutter config --enable-web
flutter run -d chrome              # Debug
flutter build web --release        # Production build → build/web/
```

**Deploy options:**
- **Local:** `cd build/web && python -m http.server 8080`
- **Firebase Hosting:** `firebase deploy`
- **Netlify/Vercel:** Drag `build/web/` folder
- **GitHub Pages:** Copy `build/web/` to gh-pages branch

### 🖥️ Windows

```bat
setup_windows.bat      :: First time only
run_debug.bat          :: Debug mode
build_and_run.bat      :: Release build + launch
```

### 📱 iOS

```bash
flutter pub get
cd ios && pod install && cd ..
flutter run -d ios
flutter build ios --release
```

---

## Prerequisites

| Platform | Requirements |
|----------|-------------|
| **Web** | Flutter SDK 3.0+, Chrome/Edge browser |
| **Windows** | Flutter SDK 3.0+, Visual Studio 2022 (C++ workload), Windows 10 SDK |
| **iOS** | Flutter SDK 3.0+, Xcode 15+, CocoaPods, Apple Dev account |

---

## Project Structure

```
fitness_app/
├── lib/
│   ├── main.dart                          # Entry (platform detection)
│   ├── models/
│   │   ├── workout_model.dart             # Data models
│   │   └── workout_data.dart              # All workout & meal data
│   ├── screens/
│   │   ├── home_screen.dart               # iOS/Android bottom nav
│   │   ├── web_home_screen.dart           # Web/Desktop responsive layout
│   │   ├── today_screen.dart              # Today overview
│   │   ├── plan_screen.dart               # Weekly plan (tabbed)
│   │   ├── checklist_screen.dart          # Daily habit checklist
│   │   ├── progress_screen.dart           # Weight chart & logging
│   │   ├── settings_screen.dart           # iOS settings & notifications
│   │   ├── web_reminders_screen.dart      # Web/Desktop reminders
│   │   └── web_settings_screen.dart       # Web/Desktop settings
│   └── services/
│       ├── notification_service.dart       # iOS/Android native notifications
│       ├── windows_notification_service.dart # Windows toast notifications
│       ├── web_notification_service.dart   # Browser Notification API
│       ├── storage_service.dart            # Local data persistence
│       └── platform_service.dart           # Platform detection helper
├── web/
│   ├── index.html                         # Web entry + JS notification engine
│   └── manifest.json                      # PWA manifest (installable)
├── ios/Runner/
│   ├── Info.plist
│   └── AppDelegate.swift
├── windows/
│   └── CMakeLists.txt
├── pubspec.yaml
├── build_web.bat                          # Build for web
├── run_web_debug.bat                      # Run web in Chrome
├── setup_windows.bat                      # Windows first-time setup
├── run_debug.bat                          # Run Windows debug
├── build_and_run.bat                      # Build Windows release
└── README.md
```

---

## Notification Schedule

| Reminder | Time | Days |
|----------|------|------|
| 🏃 Fasted Cardio | 4:50 AM | Mon, Tue, Thu |
| 🔥 Afternoon Workout | 4:45 PM | Mon, Tue, Thu |
| 💪 Gym (Push) | 8:45 AM | Wednesday |
| 💪 Gym (Pull+Legs) | 8:45 AM | Friday |
| 🔥 Circuit | 6:45 AM | Saturday |
| 💧 Water Check | 10 AM & 2 PM | Daily |
| 🥗 Dinner: No Rice! | 7:30 PM | Daily |
| ✅ Daily Checklist | 9:00 PM | Daily |
| 🛌 Sleep Reminder | 9:45 PM | Daily |
| ⚖️ Weigh-In | 6:15 AM | Monday |

---

## Web Notifications

The web version uses the **Browser Notification API**:

1. Open the app in Chrome/Edge
2. Go to **Reminders** tab
3. Click **"Enable"** → Allow notifications when browser prompts
4. Keep the tab open (or pin it) — notifications fire every minute via JS timer
5. **Install as PWA** — Click the install icon in address bar for app-like experience

> ⚠️ Browser must remain open for notifications. For background notifications, use the iOS or Windows native app.

---

## Responsive Design

The web version adapts to screen size:
- **Desktop (>768px):** Side navigation panel + centered content (max 900px)
- **Mobile (<768px):** Bottom navigation bar (same as iOS layout)

This means it works perfectly on:
- Desktop browsers (Chrome, Edge, Safari, Firefox)
- Tablet browsers (iPad, Android tablets)
- Mobile browsers (iPhone Safari, Android Chrome)

---

## Tech Stack

| Package | Purpose |
|---------|---------|
| flutter_local_notifications | iOS/Android native notifications |
| timezone | Timezone scheduling |
| shared_preferences | Local data (works on web too via localStorage) |
| fl_chart | Weight progress charts |
| intl | Date formatting |
| permission_handler | iOS permissions |
| window_manager | Windows window config |
| web | Browser Notification API interop |
| universal_html | Web platform utilities |
