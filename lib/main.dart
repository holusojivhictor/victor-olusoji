import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:victor_olusoji/presentation/routes/router.gr.dart';
import 'package:victor_olusoji/services/constants.dart';
import 'package:victor_olusoji/theme.dart';

void main() {
  runApp(MyPortfolio());
}

class MyPortfolio extends StatelessWidget {
  MyPortfolio({Key? key}) : super(key: key);

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp.router(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        darkTheme: PortfolioAppTheme.dark(),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}