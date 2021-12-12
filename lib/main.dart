import 'package:flutter/material.dart';
import 'package:kalpas_news_app/apis/auth_api.dart';
import 'package:kalpas_news_app/apis/news_api.dart';
import 'package:kalpas_news_app/screens/home_screen/home_screen.dart';
import 'package:kalpas_news_app/screens/splash_screen.dart';
import 'screens/auth_screen/auth_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NewsAPI(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => AuthAPI(),
        ),
      ],
      child: Consumer<AuthAPI>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Kalpas News",
          home: FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (ctx, snapShot) {
                if (snapShot.connectionState == ConnectionState.waiting) {
                  return SplashScreen();
                } else if (snapShot.error != null) {
                  return AuthScreen();
                } else {
                  print(snapShot.data);
                  return snapShot.data as bool ? HomeScreen() : AuthScreen();
                }
              }),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
