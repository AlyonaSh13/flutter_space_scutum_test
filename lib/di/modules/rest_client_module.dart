import 'package:dio/dio.dart';
import 'package:flutter_space_scutum_test/core/environments/app_environment.dart';
import 'package:flutter_space_scutum_test/data/datasources/remote/client/rest_client.dart';
import 'package:injectable/injectable.dart';

/// Dependency injection module for providing networking-related instances.
///
/// This module configures:
/// - a pre-configured Dio HTTP client
/// - a Retrofit-based RestClient
///
/// The `@module` annotation tells Injectable that this abstract class
/// provides external dependencies rather than being instantiated itself.
@module
abstract class RestClientModule {
  /// Provides a lazily-initialized Dio instance configured with:
  /// - the base URL from the current [AppEnvironment]
  ///
  /// The environment determines whether the app runs in dev/prod/etc.,
  /// so the base URL is injected automatically through DI.
  @lazySingleton
  Dio getDio(AppEnvironment environment) {
    final dio = Dio()..options = BaseOptions(baseUrl: environment.weatherBaseUrl);

    return dio;
  }

  /// Provides a lazily-initialized Retrofit RestClient.
  ///
  /// The RestClient will automatically use the Dio instance supplied
  /// by [getDio], inheriting all its configuration (baseUrl, interceptors, etc).
  @lazySingleton
  RestClient getRestClient(Dio dio) => RestClient(dio);
}
