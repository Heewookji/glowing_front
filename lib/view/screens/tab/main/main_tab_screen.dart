import 'package:flutter/material.dart';
import 'package:glowing_front/view/screens/message/message_room_list_screen.dart';
import 'package:glowing_front/view/screens/tab/main/feed_screen.dart';
import 'package:glowing_front/view/screens/tab/main/my_group_screen.dart';
import 'package:glowing_front/view/screens/tab/main/my_info_screen.dart';
import 'package:glowing_front/view/screens/tab/main/search_screen.dart';

class MainTabScreen extends StatefulWidget {
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedIndex = 0;
  List<Widget> _pages;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pages = [FeedScreen(), SearchScreen(), MyGroupScreen(), MyInfoScreen()];
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _selectPage(index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 150), curve: Curves.easeOutCirc);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat_bubble,
              color: Colors.white,
            ),
            onPressed: () => Navigator.of(context)
                .pushNamed(MessageRoomListScreen.routeName),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: theme.accentColor,
        backgroundColor: theme.primaryColor,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.group_work,
              size: 28,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 28,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
