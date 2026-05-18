# Expense Tracker

A Flutter application for tracking expenses and investment trades. The app uses GetX for routing, bindings, and controllers, with screen-specific controllers and bindings colocated inside each screen folder.

## Tech Stack

- Flutter SDK with Dart `^3.11.0`
- GetX for navigation, dependency binding, and controllers
- `fl_chart` for charts
- `intl` for date formatting
- `dropdown_button2` for dropdown fields
- `flutter_svg` for SVG assets
- Lato font family from local assets

## Project Structure

```text
lib/
  main.dart
  core/
    constants/       App-wide constants
    dialog/          Common dialogs
    enum/            Shared enums
    extension/       Dart and Flutter extensions
    resources/       Asset path constants
    router/          App routes and GetPage configuration
    theme/           Theme and typography setup
    utils/           Utility helpers
    widgets/         Reusable shared widgets
  data/
    models/          Data models used by screens and controllers
    repositories/    Repository layer placeholder
    services/        Service layer placeholder
  views/
    login/
      login_screen.dart
      binding/
      controller/
    home/
      home_screen.dart
      binding/
      controller/
    dashboard/
      dashboard_screen.dart
      binding/
      controller/
      widgets/
    expense/
      add_expense/
        add_expense_screen.dart
        binding/
        controller/
      expense_list/
        expense_list_screen.dart
        binding/
        controller/
        widgets/
    investment/
      add_trade/
        add_trades_screen.dart
        binding/
        controller/
      trade_list/
        trades_list_screen.dart
        binding/
        controller/
        widgets/
    profile/
      profile_screen.dart
      binding/
      controller/
```

## Screen Folder Pattern

Each screen keeps its related GetX files inside the same feature folder:

```text
views/<feature>/<screen>/
  <screen>_screen.dart
  controller/
    <screen>_controller.dart
  binding/
    <screen>_binding.dart
```

Simple top-level screens such as `login`, `home`, `dashboard`, and `profile` follow the same pattern directly under `views/<screen>/`.

Bindings register the screen dependencies. Controllers hold the screen state and actions. Reusable UI that belongs only to one screen should stay in that screen's `widgets/` folder. Shared UI belongs in `lib/core/widgets/`.

## Routing

Routes are defined in:

```text
lib/core/router/routes.dart
lib/core/router/app_router.dart
```

`app_router.dart` wires each route to its screen and binding using `GetPage`.

## Assets

Assets are configured in `pubspec.yaml`.

Current assets:

- `assets/icons/google_logo.svg`
- Lato font files in `assets/fonts/`

When adding assets, update `pubspec.yaml` and keep asset path constants in `lib/core/resources/` when they are reused.

## Setup

Install dependencies:

```bash
flutter pub get
```

Run the app:

```bash
flutter run
```

Run on a specific device:

```bash
flutter devices
flutter run -d <device_id>
```

## Useful Commands

Format Dart files:

```bash
dart format lib test
```

Analyze the project:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Clean generated build output:

```bash
flutter clean
flutter pub get
```

Build Android APK:

```bash
flutter build apk
```

Build iOS release:

```bash
flutter build ios
```

## Development Notes

- Add new screens under `lib/views/`.
- Keep screen-specific controllers and bindings inside that screen folder.
- Put shared models in `lib/data/models/`.
- Put reusable app widgets in `lib/core/widgets/`.
- Put route names in `routes.dart` and route registrations in `app_router.dart`.
- Prefer existing project widgets and styles before adding new UI patterns.
