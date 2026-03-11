import 'package:flutter/cupertino.dart';

import '../explore/explore_page.dart';
import '../favorites/favorites_page.dart';
import '../home/home_page.dart';
import '../premium/premium_page.dart';
import '../settings/settings_page.dart';

class MainShellPage extends StatelessWidget {
  const MainShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: const CupertinoTabBar(
        items: [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.compass), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.heart_fill), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.star_fill), label: 'Premium'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: 'Settings'),
        ],
      ),
      tabBuilder: (_, index) {
        final pages = <Widget>[
          const HomePage(),
          const ExplorePage(),
          const FavoritesPage(),
          const PremiumPage(),
          const SettingsPage(),
        ];
        return CupertinoTabView(builder: (_) => pages[index]);
      },
    );
  }
}
