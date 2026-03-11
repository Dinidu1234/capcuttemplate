import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../data/models/template_item.dart';
import '../../shared/widgets/template_card.dart';
import '../favorites/favorites_provider.dart';
import '../home/home_provider.dart';
import '../template_detail/template_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    this.showNavigationBar = false,
    this.title = 'Search',
  });

  final bool showNavigationBar;
  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String query = '';

  @override
  Widget build(BuildContext context) {
    final home = context.watch<HomeProvider>();
    final favorites = context.watch<FavoritesProvider>();
    final results = home.items
        .where(
          (item) => item.title.toLowerCase().contains(query.trim().toLowerCase()),
        )
        .toList();

    final content = ListView(
      padding: const EdgeInsets.all(16),
      children: [
        CupertinoSearchTextField(
          onChanged: (v) => setState(() => query = v),
        ),
        const SizedBox(height: 12),
        ...results.map(
          (item) => TemplateCard(
            item: item,
            isFavorite: favorites.isFavorite(item.id),
            onFavoriteTap: () => favorites.toggleFavorite(item.id),
            onTap: () => _openDetail(context, item),
          ),
        ),
        if (results.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: Text('No matching templates found.')),
          ),
      ],
    );

    if (!widget.showNavigationBar) return SafeArea(child: content);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text(widget.title)),
      child: SafeArea(child: content),
    );
  }

  void _openDetail(BuildContext context, TemplateItem item) {
    Navigator.of(context).push(CupertinoPageRoute(builder: (_) => TemplateDetailPage(item: item)));
  }
}
