import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:swipezone/screens/home_page.dart';
import 'package:swipezone/screens/planning_page.dart';
import 'package:swipezone/screens/select_page.dart';
import 'package:swipezone/screens/nfc_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      title: 'SwipeZone',
      debugShowCheckedModeBanner: false, // Ajout de cette ligne pour supprimer le bandeau debug
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage(title: 'SwipeZone');
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'planningpage',
            builder: (BuildContext context, GoRouterState state) {
              return const PlanningPage(title: "Planning");
            },
          ),
          GoRoute(
            path: 'selectpage',
            builder: (BuildContext context, GoRouterState state) {
              return const SelectPage(title: "Select Locations");
            },
          ),
          GoRoute(
            path: 'nfcpage',
            builder: (BuildContext context, GoRouterState state) {
              return const NFCPage();
            },
          ),
        ],
      ),
    ],
  );
}

