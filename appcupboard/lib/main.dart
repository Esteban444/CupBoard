import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';
import 'services/services.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(AppState());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(lazy: false, create: (_) => AuthService()),
        ChangeNotifierProvider(lazy: false, create: (_) => CategoryService()),
        ChangeNotifierProvider(lazy: false, create: (_) => CupBoardService()),
        //ChangeNotifierProvider(
        // lazy: false, create: (_) => DetailCupBoardService()),
        ChangeNotifierProvider(lazy: false, create: (_) => MarkService()),
        ChangeNotifierProvider(lazy: false, create: (_) => ProductsService()),
        ChangeNotifierProvider(
            lazy: false, create: (_) => ProductToExpireService()),
        ChangeNotifierProvider(
            lazy: false, create: (_) => ExpiredProdutService()),
        ChangeNotifierProvider(
            lazy: false, create: (_) => ReportCupboardService()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CupBoard',
      initialRoute: 'login',
      routes: {
        'checking': (_) => CheckAuthScreen(),
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => HomeScreen(),
        'category': (_) => CategoryScreen(),
        'detailcategory': (_) => CategoryDetailScreen(),
        'cupboard': (_) => CupBoardScreen(),
        'detailcupboard': (_) => CupBoardDetailScreen(),
        'edittingdetailcupboard': (_) => EdittingCupBoardDetailScreen(),
        'mark': (_) => MarkScreen(),
        'detailmark': (_) => MarkDetailScreen(),
        'product': (_) => ProductScreen(),
        'detailproduct': (_) => ProductDetailScreen(),
        'toExpire': (_) => ScreenToExpire(),
        'expiredProduct': (_) => ExpireProductScreen(),
        'available': (_) => ListCupBoardScreen()
      },
      theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(elevation: 0, color: Colors.indigo[900])),
    );
  }
}
