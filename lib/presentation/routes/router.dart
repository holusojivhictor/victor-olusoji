import 'package:auto_route/annotations.dart';
import 'package:victor_olusoji/presentation/home/widgets/home_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true)
  ],
)
class $AppRouter {}