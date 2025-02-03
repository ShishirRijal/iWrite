
<div align="center">

[![Built with Flutter](https://img.shields.io/badge/Built%20with-Flutter-blue.svg)](https://flutter.dev/)
[![Backend](https://img.shields.io/badge/Backend-Supabase-green.svg)](https://supabase.io/)
[![Local Storage](https://img.shields.io/badge/Local%20Storage-Hive-orange.svg)](https://docs.hivedb.dev/)
[![State Management](https://img.shields.io/badge/State-GetIt-purple.svg)](https://pub.dev/packages/get_it)
[![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-brightgreen.svg)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
</div>
 

# iWrite | A blog application with Clean Architecture


## Overview
iWrite is a sleek and user-friendly blogging platform built with Flutter. It is a learning project that implements a blog application using Clean Architecture principles. It's a practical exploration of architectural patterns, error handling, and offline-first approach in Flutter development.


## Features

- 🔐 User Authentication (Login/Signup)
- 📝 Create and Read Blog Posts
- 🌐 Online/Offline Support
- 💾 Local Data Caching
- 🎯 Functional Programming with Either
- ⚡ Exception Handling
- 🏗️ Clean Architecture Implementation

## Architecture

The application follows Clean Architecture principles, separating concerns into distinct layers:
```
lib/
├── core/
│   ├── common/           # Common utilities and widgets
│   ├── constants/        # App-wide constants
│   ├── error/           # Error handling and exceptions
│   ├── network/         # Network connectivity handling
│   ├── secrets/         # API keys and sensitive data
│   ├── theme/           # App theming
│   ├── usecases/        # Base usecase implementations
│   └── utils/           # Utility functions
│
├── features/
│   ├── auth/            # Authentication feature
│   │   ├── data/
│   │   │   ├── data_sources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── blog/            # Blog feature
│       ├── data/
│       │   ├── data_sources/
│       │   ├── models/
│       │   └── repositories/
│       ├── domain/
│       │   ├── entities/
│       │   ├── repositories/
│       │   └── usecases/
│       └── presentation/
│           ├── bloc/    # State management
│           ├── views/   # UI screens
│           └── widgets/ # Reusable widgets
│
├── dependency_injection.dart  # GetIt service locator setup
└── main.dart

```
## Program Flow

<img src="https://github.com/user-attachments/assets/0e1743f0-e038-4fd2-b239-062f4d732a3c" width="600">

The application follows a structured flow for handling user sessions and blog data:

1. **App Launch**
   - Checks user authentication status
   - Manages session state

2. **Authentication Flow**
   - Directs unauthenticated users to login
   - Provides signup option for new users
   - Validates user credentials

3. **Blog Management**
   - Fetches blogs from Supabase when online
   - Caches successful fetches in Hive
   - Falls back to cached data when offline
   - Displays blogs from local storage if fetch fails

## Data Management

- **Remote Storage**: Supabase for backend operations
- **Local Storage**: Hive for offline data persistence
- **State Management**: GetIt for dependency injection and state handling

## Technical Implementation

- **Error Handling**: Implements Either type for functional error handling
- **Network Checks**: Active internet connectivity monitoring
- **Caching Strategy**: Intelligent caching with Hive for offline access
- **Clean Code Practices**: Following SOLID principles and clean architecture patterns

## 🎯 Learning Goals

This project was developed as a learning exercise focusing on:
- Understanding Clean Architecture in Flutter
- Implementing functional programming concepts
- Managing online/offline states
- Handling data persistence
- Proper error handling

## ⚠️ Note

This is a learning project and might not include all production-ready features. It serves as a practical implementation of Clean Architecture principles and Flutter development patterns.

## Built With

- Flutter - UI Framework
- Supabase - Backend as a Service
- Hive - Local Storage
- GetIt - Dependency Injection

## Screenshots

Here are some screenshots of **iWrite**, showcasing the UI and features.

<p align="center">
    <img src="https://github.com/user-attachments/assets/443e76e1-e86b-4d23-9400-3a9dcbcefd2d" width="250">
    <img src="https://github.com/user-attachments/assets/3d2a6031-e151-4091-95b1-2cce967dc988" width="250">
</p>

<p align="center">
    <img src="https://github.com/user-attachments/assets/47202fea-7514-48f9-a1e0-659468be6226" width="250">
    <img src="https://github.com/user-attachments/assets/a188a96e-9566-4969-8efd-4069ee958a68" width="250">
</p>



---

<div align="center">
Made with ❤️ by Shishir Rijal
</div>
