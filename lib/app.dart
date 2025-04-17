import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/bottom_navigation.dart';
import 'package:mad_assessment_ba/tab_item.dart';
import 'package:mad_assessment_ba/tab_navigator.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var _currentTab = TabItem.gameHistory;
  final _navigatorKeys ={
    TabItem.gameHistory: GlobalKey<NavigatorState>(),
    TabItem.stats: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem){
    if (tabItem == _currentTab){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route)=> route.isFirst);
    }
    else{
      setState(()=> _currentTab = tabItem);
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab = !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if(isFirstRouteInCurrentTab){
          if(_currentTab != TabItem.gameHistory){
            _selectTab(TabItem.gameHistory);
            return false;
          }
        }
        return true;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.gameHistory),
          _buildOffstageNavigator(TabItem.stats),
          _buildOffstageNavigator(TabItem.profile),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem){
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        onGenerateRoute: (settings) {
          // Define your route generation logic here
          return MaterialPageRoute(
            builder: (context) => Container(), // Replace with your desired widget
          );
        },
      ),
    );
  }
}