import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_space_scutum_test/app.dart';
import 'package:flutter_space_scutum_test/di/injector.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:injectable/injectable.dart';

/// Entry point for the application.
///
/// This function performs all required startup initialization steps:
/// - Ensures Flutter bindings are ready.
/// - Loads environment variables from `.env`.
/// - Configures URL strategy for Flutter Web.
/// - Sets GoRouter behavior.
/// - Initializes dependency injection (GetIt + Injectable).
/// - Initializes Hive for local storage.
/// - Launches the root widget of the app.
Future<void> main() async {
  /// Ensures proper initialization of Flutter engine before calling async code.
  WidgetsFlutterBinding.ensureInitialized();

  /// Loads environment variables from assets/env/.env file.
  ///
  /// Typically used to store API keys, base URLs, and environment-specific settings.
  await dotenv.load(fileName: 'assets/env/.env');

  /// Enables clean URLs in Flutter Web (removes "#/" from the URL).
  usePathUrlStrategy();

  /// Makes GoRouter routes reflect imperative navigation APIs such as `go()` and `push()`.
  GoRouter.optionURLReflectsImperativeAPIs = true;

  /// Initializes dependency injection with the Development environment profile.
  configureDependencies(Environment.dev);

  /// Initializes Hive local storage for Flutter.
  await Hive.initFlutter();

  /// Starts the main application widget.
  runApp(const AppWidget());
}
