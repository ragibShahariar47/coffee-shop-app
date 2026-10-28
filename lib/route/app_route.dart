import 'package:coffee_shop_online/home/home_screen.dart';
import 'package:coffee_shop_online/home/splash_screen.dart';
import 'package:coffee_shop_online/screens/location_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRouteName {
  splashScreen,
  home,
  location,
}

class AppRoute {
  final route = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        name: AppRouteName.splashScreen.name,
        builder: (context, state) => const SplashScreen(),
        routes: [
          GoRoute(
            path: 'home',
            name: AppRouteName.home.name,
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'location',
                name: AppRouteName.location.name,
                builder: (context, state) => const LocationScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  
}

final appRouteProvider = Provider<AppRoute>((ref) {
  return AppRoute();
});