import 'package:flutter/material.dart';
import 'package:fluttertest/modules/home/presentation/home_screen.dart';
import 'package:fluttertest/modules/profile/presentation/profile_screen.dart';
import 'package:fluttertest/modules/search/presentation/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 1;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        children: const [HomeScreen(), SearchScreen(), ProfileScreen()],
      ),
      // bottomNavigationBar: buildNavBar(),
    );
  }

  Widget buildNavBar() => NavigationBar(
    height: 70,
    elevation: 0,
    animationDuration: const Duration(milliseconds: 600),
    selectedIndex: selectedIndex,
    backgroundColor: Theme.of(context).colorScheme.surface,
    indicatorShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(100),
    ),
    onDestinationSelected: (value) {
      setSelectedIndex(value);
    },
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        label: 'Home',
        selectedIcon: Icon(Icons.home),
      ),
      NavigationDestination(
        icon: Icon(Icons.search_outlined),
        label: 'Search',
        selectedIcon: Icon(Icons.search),
      ),
      NavigationDestination(
        icon: Icon(Icons.person_outline),
        label: 'Profile',
        selectedIcon: Icon(Icons.person),
      ),
    ],
  );
}
