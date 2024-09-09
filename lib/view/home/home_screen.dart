import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../core/providers/cart_provider.dart';
import 'pages/cart/cart_screen.dart';
import 'pages/main/main_screen.dart';
import 'pages/profile/profile_screen.dart';
import 'pages/search/search_screen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PageController pageController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  List<Widget> pages = const [
    MainScreen(),
    SearchScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        height: kBottomNavigationBarHeight,
        elevation: 0.0,
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: "Home",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: "Search",
          ),
          NavigationDestination(
            selectedIcon: const Icon(IconlyBold.bag2),
            icon: Badge(
              label: Text("${cartProvider.getCartItems.length}"),
              child: const Icon(IconlyLight.bag2),
            ),
            label: "Cart",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: "Profile",
          ),
        ],
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
          pageController.jumpToPage(currentIndex);
        },
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: pages,
      ),
    );
  }
}
