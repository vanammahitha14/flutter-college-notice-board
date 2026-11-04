# CampusConnect – College Notice Board

A modern, responsive, and cross-platform mobile application developed with **Flutter** and **Dart** for colleges and universities. **CampusConnect** enables students and faculty to publish, browse, filter, and view important college notices with local offline persistence.

---

### 📲 Download Android App
Download and install the latest release APK directly:
- **Direct GitHub Release:** 👉 **[Download app-release.apk (v1.0.0)](https://github.com/vanammahitha14/flutter-college-notice-board/releases/download/v1.0.0/app-release.apk)**
- **From Repository:** 👉 **[release/app-release.apk](release/app-release.apk)**

---

## 📌 Features

- **📢 Dynamic Notice Feed:** Displays college notices with real-time updates and pull-to-refresh.
- **📄 Complete Notice Details:** View full descriptions, department tags, category badges, and publication dates.
- **✍️ Add Notice with Validation:** Multi-field validated submission form (Title, Department, Category, Multi-line Description).
- **🏷️ Department Filtering:** Interactive horizontal chip filter to isolate notices by department (`CSE`, `ECE`, `EEE`, `IT`, `Mechanical`, `Civil`, `General`).
- **💾 Local Storage Persistence:** Notices are stored on the device using `shared_preferences`, keeping them available offline and across restarts.
- **🎨 Material 3 Design:** Category color coding, clean typography, elevation, and responsive cards.
- **🛡️ 4-State Architecture:** Handles Loading (`CircularProgressIndicator`), Error (`Retry`), Empty, and Populated list states gracefully.

---

## 🏗️ Clean Project Architecture

```text
lib/
├── main.dart                       # App entry point with Provider and Material 3 theme
├── models/
│   └── notice.dart                 # Data model with JSON serialization & parsing
├── services/
│   └── notice_provider.dart        # ChangeNotifier managing state & local SharedPreferences
├── widgets/
│   └── notice_card.dart            # Reusable card with department & category tags
└── screens/
    ├── home_screen.dart            # Main feed & navigation hub
    ├── notice_detail_screen.dart   # Complete notice viewer with delete option
    ├── add_notice_screen.dart      # Validated notice creation form
    └── department_screen.dart      # Filter notices by department chips
```

---

## 👥 Team Contributions & Responsibilities

| Team Member | Role | Core Contributions |
| :--- | :--- | :--- |
| **Tadiparthi Prasanna Lakshmi**<br>GitHub: [@prasannatadiparthi4-code](https://github.com/prasannatadiparthi4-code)<br>`248x1a12d6@khitguntur.ac.in` | Frontend & Core State Architecture | • Complete UI Architecture & Navigation<br>• Home Screen (`home_screen.dart`)<br>• Notice Details Screen (`notice_detail_screen.dart`)<br>• Notice Card Widget (`notice_card.dart`)<br>• Notice Model & JSON handling (`notice.dart`)<br>• State management (`notice_provider.dart`)<br>• Local storage integration (`shared_preferences`) |
| **Tenali Koushik**<br>`248x1a12e0@khitguntur.ac.in` | QA, Testing & Validation | • Department Filter Screen (`department_screen.dart`)<br>• Add Notice form validation (`add_notice_screen.dart`)<br>• Automated unit & widget tests (`test/`)<br>• Robustness testing & Defect Log (`DEFECT_LOG.md`)<br>• Release packaging & CI/CD workflow |

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/) (v3.35 or higher)
- [Dart SDK](https://dart.dev/) (v3.0+ with null-safety)
- Android Studio / VS Code with Flutter & Dart extensions
- Connected Android Device (USB Debugging) or Chrome / Windows Desktop

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/vanammahitha14/flutter-college-notice-board.git
   cd flutter-college-notice-board
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Verify code quality:**
   ```bash
   flutter analyze
   ```

4. **Run automated tests:**
   ```bash
   flutter test
   ```

5. **Launch the application:**
   ```bash
   flutter run
   ```
   *(Or target Chrome: `flutter run -d chrome`, or Windows: `flutter run -d windows`)*

---

## 🧪 Testing

The project includes unit tests for the data model and state provider, as well as widget tests for screen rendering and navigation:

```bash
flutter test
```

Expected result:
```text
00:00 +1: Notice Model Tests - JSON serialization & deserialization
00:00 +2: NoticeProvider Tests - Add, filter, and delete operations
00:01 +3: College Notice Board home screen smoke test
00:01 +3: All tests passed!
```
