# ValiRide - Modern Ride-Sharing App

A high-performance, modular Flutter ride-sharing application built with Clean Architecture principles and OpenStreetMap integration.

## Key Features
- **Real-time Map Integration**: Powered by `flutter_map` and OpenStreetMap (OSRM).
- **Direct Location Focus**: Automatically centers on the user's GPS coordinates upon startup.
- **Rider & Driver Flows**: Separate, fully-featured modules for both user roles.
- **Simulated Navigation**: Live driver movement simulation for testing and demonstration.
- **Modern UI**: Premium design with glassmorphism, smooth animations, and responsive layouts.

## Architecture Highlights
- **State Management**: Standardized using the **Cubit** pattern (Flutter BLoC).
- **Modular Codebase**: Every file is strictly maintained under **130 lines** for maximum readability and maintainability.
- **Responsive Design**: Custom extension-based scaling system.
- **Clean Routing**: Centralized navigation using `go_router`.

## Tech Stack
- **Framework**: Flutter (Dart)
- **Maps**: OpenStreetMap (via `flutter_map` & `latlong2`)
- **Routing**: Project OSRM API
- **State Management**: `flutter_bloc`
- **Navigation**: `go_router`

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/rota259/flutter_task_mopstafa.git
   ```
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run
   ```

---
Built with ❤️ by Antigravity (Advanced Agentic Coding)
