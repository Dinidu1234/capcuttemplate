import 'package:flutter/foundation.dart';

import '../../core/services/local_preferences_service.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider({required this.preferencesService});

  final LocalPreferencesService preferencesService;
  final Set<String> _favoriteIds = <String>{};
  bool _loaded = false;

  Set<String> get favoriteIds => _favoriteIds;

  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    _favoriteIds
      ..clear()
      ..addAll(await preferencesService.getFavoriteIds());
    notifyListeners();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  Future<void> toggleFavorite(String id) async {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    notifyListeners();
    await preferencesService.saveFavoriteIds(_favoriteIds);
  }
}
