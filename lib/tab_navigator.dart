import 'package:flutter/material.dart';
import 'package:mad_assessment_ba/tab_item.dart';
import 'package:mad_assessment_ba/widgets/gameHistoryScreen.dart';
import 'package:mad_assessment_ba/widgets/gamePreviewScreen.dart';

class TabNavigatorRoutes{
  static const String root = '/';
  static const String detail = '/detail'; 
}

class TabNavigator extends StatelessWidget{
  const TabNavigator({super.key, required this.navigatorKey, required this.tabItem, required MaterialPageRoute Function(dynamic routeSettings) onGenerateRoute});
  final GlobalKey<NavigatorState>? navigatorKey;
  final TabItem tabItem;

  void _push(BuildContext context){
    var routeBuilders = _routeBuilders(context);

    Navigator.push(context, MaterialPageRoute(builder: (context) => routeBuilders[TabNavigatorRoutes.detail]!(context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context){
    return {
      TabNavigatorRoutes.root: (context) => Gamehistoryscreen(
        onPush: () => _push(context),
      ),
      TabNavigatorRoutes.detail: (context) => const Gamepreviewscreen(gameHistoryID: 1),
    };
  }

  @override
  Widget build(BuildContext context){
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key:navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings){
        return MaterialPageRoute(
          builder:(context) => routeBuilders[routeSettings.name!]!(context),
        );
      },
    );
  }
}