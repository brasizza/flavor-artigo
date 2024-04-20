import 'package:flutter/material.dart';

import 'flavors.dart';
import 'pages/home/my_home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: F.title,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(
          int.parse(
            const String.fromEnvironment('BACKGROUND-COLOR', defaultValue: '0XFF000000'),
          ),
        ),
      ),
      home: _flavorBanner(
        child: const MyHomePage(),
        show: F.appFlavor == Flavor.homolog,
      ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12.0, letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
              child: child,
            )
          : Container(
              child: child,
            );
}
