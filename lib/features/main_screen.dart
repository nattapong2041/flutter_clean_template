import 'package:flutter/material.dart';
import 'package:flutter_clean_template/features/home/data/repository/news_repository_impl.dart';
import 'package:flutter_clean_template/features/home/data/service/get_news_service.dart';
import 'package:flutter_clean_template/features/home/domain/usecase/get_news.dart';
import 'package:flutter_clean_template/features/home/presentation/view/home_screen.dart';
import 'package:provider/provider.dart';

import 'home/presentation/view_model/home_view_model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late PageController _pageController;
  final List<Widget> _widgetOptions = <Widget>[
    Center(
      child: ChangeNotifierProvider(
          create: (context) => HomeViewModel(
                GetNews(NewsRepositoryImpl(service: GetNewsService())),
              ),
          child: const HomeScreen()),
    ),
    Center(
      child: Text('JUST A CHAT..'),
    ),
    Center(
      child: Text('JUST A SETTING..'),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(_selectedIndex);
    });
  }

  @override
  void initState() {
    _pageController = PageController();
    _pageController = PageController(initialPage: _selectedIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        unselectedItemColor: Theme.of(context).colorScheme.onSecondaryContainer,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: 'Setting',
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          ),
        ],
      ),
    );
  }
}
