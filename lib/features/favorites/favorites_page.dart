import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../shared/components/empty_state_view.dart';
import '../../shared/widgets/template_card.dart';
import '../home/home_provider.dart';
import '../template_detail/template_detail_page.dart';
import 'favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final favorites = context.watch<FavoritesProvider>();
    final items = home.items.where((item) => favorites.isFavorite(item.id)).toList();

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(middle: Text('Favorites')),
      child: SafeArea(
        child: items.isEmpty
            ? const EmptyStateView(message: 'No favorites yet.')
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map(
                      (item) => TemplateCard(
                        item: item,
                        isFavorite: true,
                        onFavoriteTap: () => favorites.toggleFavorite(item.id),
                        onTap: () => Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (_) => TemplateDetailPage(item: item),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}
