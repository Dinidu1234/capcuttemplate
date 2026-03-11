import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import '../../core/theme/app_colors.dart';
import '../../data/models/template_item.dart';

class TemplateCard extends StatelessWidget {
  const TemplateCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onFavoriteTap,
    required this.isFavorite,
  });

  final TemplateItem item;
  final VoidCallback onTap;
  final VoidCallback onFavoriteTap;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 14,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 82,
                  height: 82,
                  child: CachedNetworkImage(
                    imageUrl: item.tUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (_, __, ___) => Container(
                      color: CupertinoColors.systemGrey5,
                      child: const Icon(CupertinoIcons.photo),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.title.isEmpty ? 'Untitled Template' : item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: onFavoriteTap,
                child: Icon(
                  isFavorite ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                  color: isFavorite
                      ? CupertinoColors.systemRed
                      : CupertinoColors.systemGrey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
