import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'auth/login/login_screen.dart';
import 'core/logic/cache_helper.dart';
import 'core/logic/helper_methods.dart';
import 'core/providers/cart_provider.dart';
import 'core/providers/product_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/viewed_provider.dart';
import 'core/providers/wishlist_provider.dart';
import 'core/theme_services/theme_services.dart';
import 'view/home/pages/product_details/product_details.dart';
import 'view/home/pages/search/search_screen.dart';
import 'view/push_notifications/app.dart';
import 'view/push_notifications/push_notifications_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid ? await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCw3LSmKPIJeP1O-5J3KSzIUP2-pGUTT5Q",
        appId: "1:156923812026:android:d40a43aff3363295d70a83",
        messagingSenderId: "156923812026",
        projectId: "symmetric-lock-400220",
      storageBucket: "gs://symmetric-lock-400220.appspot.com",
    ),
  ) : await Firebase.initializeApp();
  PushNotificationsService.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WishlistProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ViewedProdProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return ScreenUtilInit(
            designSize: const Size(375, 812),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) => MaterialApp(
              title: "Talabat",
              theme: Styles.themeData(
                isDarkTheme: themeProvider.getIsDarkTheme,
                context: context,
              ),
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,
              home: child,
              routes: {
                ProductDetails.routeName: (context) => const ProductDetails(),
                SearchScreen.routeName: (context) => const SearchScreen(),
              },
            ),
            child: const LoginScreen(),
          );
        },
      ),
    );
  }
}
