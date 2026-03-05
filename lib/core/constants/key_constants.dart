import 'package:flutter/cupertino.dart';

/// Semantic keys for widgets used in tests and integration tests.
/// Enables reliable finding of widgets by key (e.g. driver or find.byKey).
class KeyConstants {
  static Key loadingIndicator = const Key('loading_indicator');
  static Key errorText = const Key('error_text');
  static Key noDataText = const Key('no_data_text');
  static Key movieGrid = const Key('movie_grid');
  static Key refreshIndicator = const Key('refresh_indicator');
  static Key movieCard = const Key('movie_card');
}
