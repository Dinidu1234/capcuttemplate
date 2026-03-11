import 'package:flutter/foundation.dart';

import '../../core/constants/app_constants.dart';
import '../../data/models/template_item.dart';
import '../../data/repositories/template_repository.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({required this.repository});

  final TemplateRepository repository;

  final List<TemplateItem> _items = [];
  bool _isInitialLoading = false;
  bool _isPaginating = false;
  bool _isRefreshing = false;
  bool _hasMore = true;
  String? _error;
  String? _paginationError;
  bool _initialized = false;
  int _nextOffset = 0;

  List<TemplateItem> get items => List.unmodifiable(_items);
  bool get isInitialLoading => _isInitialLoading;
  bool get isPaginating => _isPaginating;
  bool get isRefreshing => _isRefreshing;
  bool get hasMore => _hasMore;
  String? get error => _error;
  String? get paginationError => _paginationError;

  Future<void> initialize() async {
    if (_initialized || _isInitialLoading) return;
    _initialized = true;
    _isInitialLoading = true;
    _error = null;
    _paginationError = null;
    notifyListeners();

    final local = await repository.getLocalPage(0);
    if (local.isNotEmpty) {
      _setItems(local);
      _isInitialLoading = false;
      notifyListeners();
      await refresh(silent: true);
      return;
    }

    try {
      final remote = await repository.fetchRemotePage(0);
      _setItems(remote);
      await repository.cacheTemplates(remote);
    } catch (_) {
      _error = 'Failed to load templates. Please try again.';
    }
    _isInitialLoading = false;
    notifyListeners();
  }

  Future<void> refresh({bool silent = false}) async {
    if (_isRefreshing) return;
    _isRefreshing = true;
    if (!silent) {
      _error = null;
      _paginationError = null;
      notifyListeners();
    }

    try {
      final remote = await repository.fetchRemotePage(0);
      _items
        ..clear()
        ..addAll(_dedupe(remote));
      _nextOffset = AppConstants.pageSize;
      _hasMore = remote.length >= AppConstants.pageSize;
      _error = null;
      await repository.cacheTemplates(_items);
    } catch (_) {
      if (_items.isEmpty) {
        final fallbackLocal = await repository.getLocalPage(0);
        if (fallbackLocal.isNotEmpty) {
          _setItems(fallbackLocal);
          _error = null;
        } else {
          _error = 'Unable to refresh templates.';
        }
      }
    }

    _isRefreshing = false;
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (_isInitialLoading || _isPaginating || _isRefreshing || !_hasMore) return;
    _isPaginating = true;
    _paginationError = null;
    notifyListeners();

    try {
      final remote = await repository.fetchRemotePage(_nextOffset);
      if (remote.isEmpty) {
        _hasMore = false;
      } else {
        final merged = _dedupe([..._items, ...remote]);
        _items
          ..clear()
          ..addAll(merged);
        _nextOffset += AppConstants.pageSize;
        _hasMore = remote.length >= AppConstants.pageSize;
        await repository.cacheTemplates(remote);
      }
    } catch (_) {
      _paginationError = 'Could not load more templates.';
    }

    _isPaginating = false;
    notifyListeners();
  }

  void _setItems(List<TemplateItem> incoming) {
    _items
      ..clear()
      ..addAll(_dedupe(incoming));
    _nextOffset = AppConstants.pageSize;
    _hasMore = incoming.length >= AppConstants.pageSize;
  }

  List<TemplateItem> _dedupe(List<TemplateItem> list) {
    return {for (final item in list) item.id: item}.values.toList();
  }
}
