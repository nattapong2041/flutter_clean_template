import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'news/data/repository/news_repository_impl.dart';
import 'news/data/service/get_news_service.dart';
import 'news/domain/usecase/get_news.dart';
import 'news/presentation/view/news_screen.dart';
import 'news/presentation/view_model/news_view_model.dart';

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
          create: (context) => NewsViewModel(
                GetNews(NewsRepositoryImpl(service: GetNewsService())),
              ),
          child: const NewsScreen()),
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
            icon: const Icon(Icons.feed),
            label: 'Feeds',
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
