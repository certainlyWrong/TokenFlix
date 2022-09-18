import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tokenflix/view/home/page/movies.page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  late final PageController pageController;

  @override
  void initState() {
    pageController = PageController(
      initialPage: selectedIndex.value,
      keepPage: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    selectedIndex.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TokenFlix'),
      ),
      body: PageView(
        controller: pageController,
        dragStartBehavior: DragStartBehavior.down,
        onPageChanged: (index) {
          selectedIndex.value = index;
        },
        children: const [
          MoviesPage(),
          Center(
            child: Text('Favorites'),
          ),
          Center(
            child: Text('Search'),
          ),
          Center(
            child: Text('Settings'),
          ),
        ],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, int value, child) {
          return BottomNavigationBar(
            currentIndex: value,
            onTap: (index) {
              selectedIndex.value = index;
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            selectedItemColor: Theme.of(context).colorScheme.secondary,
            unselectedItemColor: Theme.of(context).colorScheme.onSurface,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.movie),
                label: 'Movies',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          );
        },
      ),
    );
  }
}
