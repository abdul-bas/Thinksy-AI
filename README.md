# Thinksy AI

<p align="center">
  <img src="assets/images/icon.png" alt="Thinksy AI logo" width="120" />
</p>

<p align="center">
  <b>Ask. Think. Discover.</b><br/>
  A cross-platform AI chat app built with Flutter, BLoC and the Gemini API.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.4+-0175C2?logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/State-Flutter%20BLoC-6C5CE7" alt="BLoC" />
  <img src="https://img.shields.io/badge/Auth-Firebase-FFCA28?logo=firebase&logoColor=black" alt="Firebase" />
</p>

Thinksy AI lets users sign in with Firebase Authentication, ask questions, and receive AI-generated responses from Google Gemini in a clean, modern chat interface.

## Table of Contents

- [Screenshots](#screenshots)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Running the App](#running-the-app)
- [Security Notes](#security-notes)
- [Roadmap](#roadmap)
- [Author](#author)

## Screenshots

<p align="center">
  <img src="screenshots/splash.png" alt="Splash" width="200" />
  <img src="screenshots/login.png" alt="Login" width="200" />
  <img src="screenshots/register.png" alt="Register" width="200" />
  <img src="screenshots/chat.png" alt="Chat" width="200" />
</p>

| Splash | Login | Register | Forgot password | Chat |
| :----: | :---: | :------: | :-------------: | :--: |
| `screenshots/splash.png` | `screenshots/login.png` | `screenshots/register.png` | `screenshots/forgot_password.png` | `screenshots/chat.png` |

> Add your app screenshots to the `screenshots/` folder using the file names above.

## Features

- **AI chat:** ask questions and get Gemini-generated answers, with conversation context maintained through `previous_interaction_id`
- **Authentication:** email/password login, registration and password reset with Firebase Auth
- **Session handling:** an auth gate routes users to the chat or login screen based on their sign-in state
- **Splash screen:** animated launch screen with the app logo
- **Modern UI:** Material 3 design with light and dark themes, a typing indicator and suggestion chips
- **Error handling:** clear, user-friendly messages for network and authentication errors

## Tech Stack

| Area             | Technology                       |
| ---------------- | -------------------------------- |
| Framework        | Flutter (Dart 3.4+)              |
| State management | `flutter_bloc` (BLoC only)       |
| Networking       | `dio`                            |
| Authentication   | `firebase_auth`, `firebase_core` |
| Configuration    | `flutter_dotenv`                 |
| Value equality   | `equatable`                      |
| AI model         | Google Gemini (Interactions API) |

## Architecture

The project follows **Clean Architecture** and is organized by feature. Each feature has three layers:

- **Domain:** entities, repository contracts and use cases (pure Dart, no framework dependencies)
- **Data:** remote data sources and repository implementations
- **Presentation:** BLoCs, controllers, pages and widgets

Dependencies point inward: presentation depends on domain, and data implements domain contracts. The UI never calls an API directly.

**Conventions**

- Flutter BLoC is the only state management solution
- No private methods or classes, and no underscores in method or class names

## Project Structure

<p align="center">
  <img src="docs/images/project-structure-1.png" alt="Project structure: core, auth and chat features" width="320" />
  <img src="docs/images/project-structure-2.png" alt="Project structure: chat, splash and root files" width="320" />
</p>

```
lib/
├── main.dart
├── thinksy_ai_app.dart
├── firebase_options.dart
├── core/
│   ├── network/          # Dio client
│   ├── utils/
│   │   ├── enum/         # Form status and other enums
│   │   └── validators/   # Form validators
│   └── widgets/          # Shared widgets
└── features/
    ├── splash/
    │   └── presentation/ # bloc, controller, pages
    ├── auth/
    │   ├── data/         # Firebase data source, repository implementation
    │   ├── domain/       # AuthUser, AuthRepository, use cases
    │   └── presentation/ # bloc, controller, pages, widgets
    └── chat/
        ├── data/         # Gemini data source, repository implementation
        ├── domain/       # ChatMessage, ChatReply, ChatRepository, SendMessage
        └── presentation/ # bloc, controller, pages, widgets
```

## Getting Started

### Prerequisites

- Flutter SDK 3.x with Dart 3.4 or higher
- A Firebase project
- A Gemini API key from [Google AI Studio](https://aistudio.google.com/)

### Installation

```bash
git clone <your-repository-url>
cd thinksy_ai
flutter pub get
```

## Configuration

### 1. Environment variables

Copy the example file and add your key:

```bash
cp .env.example .env
```

```env
GEMINI_API_KEY=your_gemini_api_key_here
GEMINI_MODEL=gemini-3.8-flash
```

`GEMINI_MODEL` is optional and defaults to `gemini-3.8-flash`. The `.env` file is listed in `.gitignore` and must never be committed.

### 2. Firebase

1. Create a Firebase project.
2. Enable **Authentication > Sign-in method > Email/Password**.
3. Connect the app:
   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```
4. Initialize Firebase with the generated options in `main.dart`:
   ```dart
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );
   ```

### 3. Android

- Set `minSdk` to 23 or higher.
- Make sure `AndroidManifest.xml` includes:
  ```xml
  <uses-permission android:name="android.permission.INTERNET" />
  ```

### 4. Launcher icon (optional)

```bash
dart run flutter_launcher_icons
```

## Running the App

```bash
flutter run
```

## Security Notes

- `.env` is bundled as an asset, so its values can be extracted from a release build. This is acceptable for development only.
- For production, route Gemini requests through a backend service and keep the API key on the server.

## Roadmap

- [ ] Google sign-in
- [ ] Email verification
- [ ] Persistent chat history
- [ ] Streaming responses
- [ ] Image input

## Author

Built by **Basith**.
