import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../core/utils/app_launch_utils.dart';
import '../../data/models/template_item.dart';
import '../favorites/favorites_provider.dart';

class TemplateDetailPage extends StatelessWidget {
  const TemplateDetailPage({super.key, required this.item});

  final TemplateItem item;

  @override
  Widget build(BuildContext context) {
    final favorites = context.watch<FavoritesProvider>();
    final isFavorite = favorites.isFavorite(item.id);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Template'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () => favorites.toggleFavorite(item.id),
          child: Icon(
            isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            color: isFavorite
                ? CupertinoColors.systemRed
                : CupertinoColors.systemGrey,
          ),
        ),
      ),
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 220,
                child: CachedNetworkImage(
                  imageUrl: item.tUrl,
                  fit: BoxFit.cover,
                  errorWidget: (_, __, ___) => Container(
                    color: CupertinoColors.systemGrey5,
                    child: const Center(child: Icon(CupertinoIcons.photo)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              item.title.isEmpty ? 'Untitled Template' : item.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            CupertinoButton.filled(
              onPressed: () => AppLaunchUtils.openTemplateSmart(item.vUrl, context),
              child: const Text('Open in CapCut'),
            ),
            const SizedBox(height: 10),
            CupertinoButton(
              onPressed: () {},
              child: const Text('Share (coming soon)'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Related templates',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text('More related content will be available in a future update.'),
          ],
        ),
      ),
    );
  }
}
