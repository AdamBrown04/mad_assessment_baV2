import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key, required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        _buildItem(TabItem.gameHistory),
        _buildItem(TabItem.stats),
        _buildItem(TabItem.profile),
      ],
      onTap: (index)=> onSelectTab(TabItem.values[index]),
      currentIndex: currentTab.index,
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    switch (tabItem) {
      case TabItem.gameHistory:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        );
      case TabItem.stats:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Stats',
        );
      case TabItem.profile:
        return const BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        );
    }
  }
}