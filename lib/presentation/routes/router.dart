import 'package:auto_route/annotations.dart';
import 'package:victor_olusoji/presentation/home/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true)
  ],
)
class $AppRouter {}