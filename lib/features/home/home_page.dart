import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../data/models/template_item.dart';
import '../../shared/components/empty_state_view.dart';
import '../../shared/components/error_state_view.dart';
import '../../shared/widgets/template_card.dart';
import '../favorites/favorites_provider.dart';
import '../search/search_page.dart';
import '../template_detail/template_detail_page.dart';
import 'home_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().initialize();
    });
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 260) {
      context.read<HomeProvider>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, FavoritesProvider>(
      builder: (context, home, favorites, _) {
        return CupertinoPageScaffold(
          navigationBar: const CupertinoNavigationBar(
            middle: Text('Cap Template'),
          ),
          child: SafeArea(
            child: home.isInitialLoading
                ? const Center(child: CupertinoActivityIndicator(radius: 14))
                : home.error != null && home.items.isEmpty
                    ? ErrorStateView(
                        message: home.error!,
                        onRetry: () => home.refresh(),
                      )
                    : CustomScrollView(
                        controller: _controller,
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        slivers: [
                          CupertinoSliverRefreshControl(
                            onRefresh: home.refresh,
                          ),
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                            sliver: SliverList(
                              delegate: SliverChildListDelegate([
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (_) => const SearchPage(
                                          showNavigationBar: true,
                                          title: 'Search',
                                        ),
                                      ),
                                    );
                                  },
                                  child: const AbsorbPointer(
                                    child: CupertinoSearchTextField(),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                const Text(
                                  'Featured Templates',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                if (home.items.isEmpty)
                                  const SizedBox(
                                    height: 320,
                                    child: EmptyStateView(
                                      message: 'No templates available right now.',
                                    ),
                                  )
                                else
                                  ...home.items.map(
                                    (item) => TemplateCard(
                                      item: item,
                                      isFavorite: favorites.isFavorite(item.id),
                                      onFavoriteTap: () =>
                                          favorites.toggleFavorite(item.id),
                                      onTap: () => _openDetail(context, item),
                                    ),
                                  ),
                                if (home.isPaginating)
                                  const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 18),
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  ),
                                if (home.paginationError != null)
                                  Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          home.paginationError!,
                                          style: const TextStyle(
                                            color: CupertinoColors.systemGrey,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: home.loadMore,
                                          child: const Text('Retry'),
                                        ),
                                      ],
                                    ),
                                  ),
                              ]),
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }

  void _openDetail(BuildContext context, TemplateItem item) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TemplateDetailPage(item: item),
      ),
    );
  }
}
