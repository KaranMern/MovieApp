// test/presentation/provider/theme_provider_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample/features/movies/presentation/dashboard_providers.dart';
import 'package:sample/features/movies/providers/theme_notifier.dart';

/// Unit tests for [ThemeNotifier]. Verifies initial state is [ThemeMode.light],
/// [toggleTheme] switches light/dark, and [setDark]/[setLight] set state correctly.
void main() {
  late ProviderContainer container;
  late ThemeNotifier notifier;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
    notifier = container.read(themeProvider.notifier);
  });

  test('initial state is ThemeMode.light', () {
    expect(container.read(themeProvider), ThemeMode.light);
  });

  test('toggleTheme switches state correctly', () {
    expect(container.read(themeProvider), ThemeMode.light);
    notifier.toggleTheme();
    expect(container.read(themeProvider), ThemeMode.dark);
    notifier.toggleTheme();
    expect(container.read(themeProvider), ThemeMode.light);
  });

  test('setDark sets state to ThemeMode.dark', () {
    notifier.setDark();
    expect(container.read(themeProvider), ThemeMode.dark);
  });

  test('setLight sets state to ThemeMode.light', () {
    notifier.setDark();
    notifier.setLight();
    expect(container.read(themeProvider), ThemeMode.light);
  });
}
