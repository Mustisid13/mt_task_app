import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mt_task_app/core/Routing/route_names.dart';
import 'package:mt_task_app/features/Shopping/Presentation/CartViewPage.dart';
import 'package:mt_task_app/features/Shopping/Presentation/Controllers/HomeBindings.dart';
import 'package:mt_task_app/features/Shopping/Presentation/HomeViewPage.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return getPageRoutes(
          routeName: homePage,
          settings: settings,
          page: () => const HomeViewPage(),
          bindings: [
            HomeBindings(),
          ]);
    case cartPage:
      return getPageRoutes(
          routeName: homePage,
          settings: settings,
          page: () => const CartViewPage(),
          bindings: [
            HomeBindings(),
          ]);
    default:
      return GetPageRoute(
        page: () => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

/// Use This Method To Call Pages
PageRoute getPageRoutes(
    {required String routeName,
    required Function page,
    required RouteSettings settings,
    List<Bindings>? bindings}) {
  return GetPageRoute(
      page: () => page(),
      routeName: routeName,
      settings: settings,
      bindings: bindings);
}
