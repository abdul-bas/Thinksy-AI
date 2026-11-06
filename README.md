# Thinksy AI

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.4+-0175C2?logo=dart&logoColor=white)
![State Management](https://img.shields.io/badge/State-Flutter%20BLoC-6C5CE7)
![Firebase](https://img.shields.io/badge/Auth-Firebase-FFCA28?logo=firebase&logoColor=black)

Thinksy AI is a cross-platform AI chat application built with Flutter and powered by the Google Gemini API. Users sign in with Firebase Authentication, ask questions, and receive AI-generated responses in a clean, modern chat interface.

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

### App

<p align="center">
  <img src="screenshots/splash.png" alt="Splash screen" width="200" />
  <img src="screenshots/login.png" alt="Login screen" width="200" />
  <img src="screenshots/register.png" alt="Register screen" width="200" />
  <img src="screenshots/chat.png" alt="Chat screen" width="200" />
</p>

### Project structure

<p align="center">
  <img src="docs/images/project-structure-1.png" alt="Project structure: core, auth and chat" width="320" />
  <img src="docs/images/project-structure-2.png" alt="Project structure: chat, splash and root files" width="320" />
</p>

## Features

- **AI chat:** ask questions and get Gemini-generated answers, with conversation context maintained through `previous_interaction_id`
- **Authentication:** email/password login, registration and password reset with Firebase Auth
- **Session handling:** an auth gate routes users to the chat or login screen based on their sign-in state
- **Splash screen:** animated launch screen
- **Modern UI:** Material 3 design with light and dark themes, typing indicator and suggestion chips
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
- **Presentation:** BLoCs, pages and widgets

Dependencies point inward: presentation depends on domain, and data implements domain contracts. The UI never calls an API directly.

**Conventions**

- Flutter BLoC is the only state management solution
- No private methods or classes, and no underscores in method or class names

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── constants/        # API constants
│   ├── error/            # Failure type
│   ├── network/          # Dio client
│   └── utils/            # Form status, validators
└── features/
    ├── splash/
    │   └── presentation/ # SplashBloc, SplashPage
    ├── auth/
    │   ├── data/         # Firebase data source, repository implementation
    │   ├── domain/       # AuthUser, AuthRepository, use cases
    │   └── presentation/ # AuthBloc, Login/Register/ForgotPassword blocs, pages, widgets
    └── chat/
        ├── data/         # Gemini data source, repository implementation
        ├── domain/       # ChatMessage, ChatReply, ChatRepository, SendMessage
        └── presentation/ # ChatBloc, ChatPage, widgets
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
GEMINI_MODEL=gemini-3-flash-preview
```

`GEMINI_MODEL` is optional and defaults to `gemini-3-flash-preview`. The `.env` file is listed in `.gitignore` and must never be committed.

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

## Running the App

```bash
flutter run
```

## Security Notes

- `.env` is bundled as an asset, so its values can be extracted from a release build. This is acceptable for development only.
- For production, route Gemini requests through a backend service and keep the API key on the server.


## Author

Built by **Basith**.
